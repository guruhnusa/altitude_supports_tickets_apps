// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/build_context_ext.dart';
import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/text_field/custom_text_field.dart';
import '../../../../core/helpers/widgets/custom_appbar.dart';
import '../../../../core/helpers/widgets/custom_drop_down.dart';
import '../../../../core/utils/constant/app_colors.dart';
import '../../../auth/presentation/controllers/is_agent_provider.dart';
import '../../data/datasources/local/status_local_data.dart';
import '../../domain/models/filter_model.dart';
import '../../domain/models/ticket_model.dart';
import '../../domain/usecases/param/ticket_param.dart';
import '../controllers/update_ticket_provider.dart';

class DetailTicketPage extends HookConsumerWidget {
  final TicketModel ticket;
  const DetailTicketPage({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: ticket.title);
    final descriptionController = useTextEditingController(text: ticket.description);

    final selectStatus = useState<FilterModel>(
      statusLocalData.firstWhere((element) => ticket.status == element.value),
    );

    final isAgentState = ref.watch(isAgentProvider);

    ref.listen(
      updateTicketProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          context.pop();
          context.showSuccessSnackbar(message: 'Ticket updated');
        } else if (next is AsyncError) {
          context.showErrorSnackbar(message: 'Failed to update ticket');
        }
      },
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Ticket',
        onBack: () {
          context.pop();
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Title',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral900,
            ),
          ),
          const Gap(12),
          CustomTextField(
            controller: titleController,
            label: 'Input Title',
            isReadOnly: true,
          ),
          const Gap(16),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral900,
            ),
          ),
          const Gap(12),
          CustomTextField(
            controller: descriptionController,
            label: '',
            minLines: 5,
            maxLines: null,
            isReadOnly: true,
          ),
          const Gap(16),
          const Text(
            'Status',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral900,
            ),
          ),
          const Gap(12),
          isAgentState.when(
            data: (data) {
              log('isAgentState: $data');
              if (data) {
                return Column(
                  children: [
                    CustomDropDown<FilterModel>(
                      hint: 'Status',
                      selectedItem: selectStatus,
                      item: statusLocalData,
                      itemLabelBuilder: (value) => value.title,
                      onChanged: (value) {
                        selectStatus.value = value!;
                      },
                    ),
                    const Gap(24),
                    Button.filled(
                      onPressed: () {
                        ref.read(updateTicketProvider.notifier).action(
                              param: TicketParam(
                                id: ticket.id,
                                title: titleController.text,
                                description: descriptionController.text,
                                status: selectStatus.value.value,
                              ),
                            );
                      },
                      label: 'Update Ticket',
                    ),
                  ],
                );
              } else {
                return Text(
                  selectStatus.value.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ticket.status == 'Open'
                        ? Colors.green.withOpacity(0.8)
                        : ticket.status == 'On Progress'
                            ? Colors.yellow.withOpacity(0.8)
                            : Colors.red.withOpacity(0.8),
                  ),
                );
              }
            },
            error: (error, stackTrace) {
              return const SizedBox();
            },
            loading: () {
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
