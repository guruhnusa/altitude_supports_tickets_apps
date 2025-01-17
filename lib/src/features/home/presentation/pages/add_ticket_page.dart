import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/text_field/custom_text_field.dart';
import '../../../../core/helpers/widgets/custom_appbar.dart';
import '../../../../core/utils/constant/app_colors.dart';

class AddTicketPage extends HookConsumerWidget {
  const AddTicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();

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
            onPressed: () {},
            label: 'Submit Ticket',
          ),
        ],
      ),
    );
  }
}
