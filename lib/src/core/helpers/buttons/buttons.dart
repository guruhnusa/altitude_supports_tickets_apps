import 'package:flutter/material.dart';

import '../../assets/fonts.gen.dart';
import '../../utils/constant/app_colors.dart';

enum ButtonStyle { filled, outlined }

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 50.0,
    this.style = ButtonStyle.filled,
    this.color = AppColors.indigo,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.borderRadius = 12.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 16.0,
    this.borderColor = AppColors.indigo,
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 50.0,
    this.style = ButtonStyle.outlined,
    this.color = Colors.white,
    this.textColor = AppColors.indigo,
    this.width = double.infinity,
    this.borderRadius = 12.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 16.0,
    this.borderColor = AppColors.indigo,
  });

  final Function() onPressed;
  final String label;
  final ButtonStyle style;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final bool disabled;
  final double fontSize;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyle.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ).copyWith(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return AppColors.neutral200;
                    }
                    return color;
                  },
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.poppins,
                    ),
                  ),
                ],
              ),
            )
          : OutlinedButton(
              onPressed: disabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                side: BorderSide(color: borderColor, width: 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  Text(
                    label,
                    maxLines: 1,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.poppins,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
