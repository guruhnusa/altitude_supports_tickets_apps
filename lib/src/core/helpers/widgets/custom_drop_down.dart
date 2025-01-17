// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../assets/fonts.gen.dart';
import '../../utils/constant/app_colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.selectedItem,
    required this.item,
    this.onChanged,
    required this.hint,
    required this.itemLabelBuilder,
  });

  final ValueNotifier<T?> selectedItem;
  final List<T> item;
  final void Function(T?)? onChanged;
  final String hint;
  //item label builder
  final String Function(T) itemLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: selectedItem.value == null ? AppColors.neutral200 : AppColors.neutral500, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        value: selectedItem.value,
        hint: Text(
          hint,
          style: const TextStyle(
            color: AppColors.neutral200,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        items: item.map((e) {
          return DropdownMenuItem<T>(
            value: e,
            child: Text(
              itemLabelBuilder(e),
              style: const TextStyle(
                color: AppColors.neutral900,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.poppins,
              ),
            ),
          );
        }).toList(),
        dropdownColor: Colors.white,
        onChanged: onChanged,
        iconEnabledColor: const Color(0xFF121926),
        iconDisabledColor: const Color(0xFF121926),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        underline: const SizedBox.shrink(),
      ),
    );
  }
}
