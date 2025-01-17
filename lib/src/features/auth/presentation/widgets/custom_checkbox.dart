import 'package:flutter/material.dart';

import '../../../../core/utils/constant/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.isAgree,
    this.onChanged,
  });

  final ValueNotifier<bool> isAgree;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isAgree.value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.indigo;
        }
        return Colors.white;
      }),
      checkColor: Colors.white,
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(color: AppColors.indigo);
        }
        return const BorderSide(color: Colors.grey);
      }),
    );
  }
}
