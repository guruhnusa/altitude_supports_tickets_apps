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
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final int? minLines;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.filled = Colors.transparent,
    this.textColor = AppColors.primary500,
    this.labelColor = AppColors.primary200,
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
    this.inputFormatters,
    this.error,
    this.minLines,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPassword = true;
  bool isFilled = false;

  @override
  void initState() {
    super.initState();

    isFilled = widget.controller.text.isNotEmpty;

    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    final newIsFilled = widget.controller.text.isNotEmpty;
    if (newIsFilled != isFilled) {
      setState(() {
        isFilled = newIsFilled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.isReadOnly,
      textInputAction: widget.textInputAction,
      style: const TextStyle(
        color: AppColors.neutral900,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      validator: widget.validator,
      obscureText: widget.obscureText ? isPassword : false,
      obscuringCharacter: '*',
      inputFormatters: widget.inputFormatters,
      onChanged: (text) {
        setState(() {
          isFilled = text.isNotEmpty;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
      },
      keyboardType: widget.keyboardType,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        counter: const Offstage(),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
        suffixIcon: widget.obscureText
            ? GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 14, bottom: 8),
                  child: Icon(
                    isPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.neutral200,
                    size: 20,
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
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        hintText: widget.label,
        errorText: widget.error,
        hintStyle: const TextStyle(
          color: AppColors.neutral200,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: 16,
        ),
        filled: true,
        fillColor: widget.filled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.neutral200,
          ),
        ),
        enabledBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: widget.isReadOnly
                      ? AppColors.neutral50
                      : (isFilled ? AppColors.neutral500 : AppColors.neutral200),
                  width: 1,
                ),
              )
            : InputBorder.none,
        disabledBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.neutral200,
                ),
              )
            : InputBorder.none,
        focusedBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: widget.isReadOnly
                      ? AppColors.neutral50
                      : (isFilled ? AppColors.neutral500 : AppColors.neutral200),
                  width: 1,
                ),
              )
            : InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
    );
  }
}
