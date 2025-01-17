import 'package:flutter/material.dart';

import '../../utils/constant/app_colors.dart';

enum ButtonStyle { filled, outlined }

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 60.0,
    this.style = ButtonStyle.filled,
    this.color = Colors.transparent,
    this.textColor = AppColors.primaryWhite,
    this.width = double.infinity,
    this.borderRadius = 15.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 20.0,
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 60.0,
    this.style = ButtonStyle.outlined,
    this.color = Colors.white,
    this.textColor = AppColors.primaryWhite,
    this.width = double.infinity,
    this.borderRadius = 15.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 20.0,
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyle.filled
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: disabled
                    ? Colors.grey[100] // Atur ke abu-abu jika disable
                    : color,
              ),
              child: ElevatedButton(
                onPressed: disabled ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shadowColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: OutlinedButton(
                onPressed: disabled ? null : onPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
