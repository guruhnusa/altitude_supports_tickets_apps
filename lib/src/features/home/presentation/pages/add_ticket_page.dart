import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/build_context_ext.dart';
import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/text_field/custom_text_field.dart';
import '../../../../core/helpers/widgets/custom_appbar.dart';
import '../../../../core/utils/constant/app_colors.dart';
import '../../domain/usecases/param/ticket_param.dart';
import '../controllers/add_ticket_provider.dart';

class AddTicketPage extends HookConsumerWidget {
  const AddTicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final buttonEnabled = useState(
      titleController.text.isNotEmpty && descriptionController.text.isNotEmpty,
    );

    useEffect(() {
      listener() {
        buttonEnabled.value = titleController.text.isNotEmpty && descriptionController.text.isNotEmpty;
      }

      titleController.addListener(listener);
      descriptionController.addListener(listener);
      return () {
        titleController.removeListener(listener);
        descriptionController.removeListener(listener);
      };
    }, [titleController, descriptionController]);

    ref.listen(
      addTicketProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          context.pop();
        } else if (next is AsyncError) {
          context.showErrorSnackbar(message: 'Failed to add ticket');
        }
      },
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Ticket',
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
          ),
          const Gap(24),
          Button.filled(
            disabled: !buttonEnabled.value,
            onPressed: () {
              ref.read(addTicketProvider.notifier).action(
                    param: TicketParam(
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                  );
            },
            label: 'Submit Ticket',
          ),
        ],
      ),
    );
  }
}
