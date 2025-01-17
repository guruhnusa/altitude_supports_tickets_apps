// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constant/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Color filled;
  final Color textColor;
  final Color labelColor;
  final bool isBorder;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool isRequired;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final VoidCallback? suffixOnPressed;
  final double height;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.filled = Colors.transparent,
      this.textColor = Colors.black,
      this.labelColor = AppColors.primaryGrey2,
      this.isBorder = true,
      this.keyboardType = TextInputType.text,
      this.isReadOnly = false,
      this.onChanged,
      this.obscureText = false,
      this.isRequired = false,
      this.validator,
      this.maxLength,
      this.textInputAction,
      this.suffixOnPressed,
      this.height = 60,
      this.inputFormatters,
      this.textAlign = TextAlign.start,
      this.textAlignVertical});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      height: widget.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.isReadOnly,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textInputAction: widget.textInputAction,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryGreen,
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        maxLength: widget.maxLength,
        validator: widget.validator,
        obscureText: widget.obscureText ? isPassword : false,
        obscuringCharacter: '*',
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          counter: const Offstage(),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.primaryGrey2,
                    ),
                  ),
                  onTap: () {
                    setState(
                      () {
                        isPassword = !isPassword;
                      },
                    );
                  },
                )
              : null,
          errorStyle: const TextStyle(
            color: AppColors.primaryRed,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
            color: widget.labelColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: widget.obscureText ? 8 : 12, top: widget.obscureText ? 10 : 12),
          filled: true,
          fillColor: widget.filled,
        ),
      ),
    );
  }
}
