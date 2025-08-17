import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool isLoading;
  final Widget? icon;
  final ButtonType type;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 50,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.padding,
    this.borderRadius,
    this.isLoading = false,
    this.icon,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color txtColor;
    BorderSide? border;

    switch (type) {
      case ButtonType.primary:
        bgColor = backgroundColor ?? AppStyles.primaryBlue;
        txtColor = textColor ?? AppStyles.white;
        break;
      case ButtonType.secondary:
        bgColor = backgroundColor ?? AppStyles.white;
        txtColor = textColor ?? AppStyles.primaryBlue;
        border = const BorderSide(color: AppStyles.primaryBlue);
        break;
      case ButtonType.facebook:
        bgColor = backgroundColor ?? AppStyles.facebookBlue;
        txtColor = textColor ?? AppStyles.white;
        break;
      case ButtonType.google:
        bgColor = backgroundColor ?? AppStyles.white;
        txtColor = textColor ?? AppStyles.grey800;
        border = const BorderSide(color: AppStyles.grey300);
        break;
      case ButtonType.warning:
        bgColor = backgroundColor ?? AppStyles.warning;
        txtColor = textColor ?? AppStyles.white;
        break;
      case ButtonType.success:
        bgColor = backgroundColor ?? AppStyles.success;
        txtColor = textColor ?? AppStyles.white;
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? AppStyles.radiusMedium),
            side: border ?? BorderSide.none,
          ),
          elevation: type == ButtonType.secondary || type == ButtonType.google ? 0 : 2,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(txtColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: AppStyles.smallSpace),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: txtColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

enum ButtonType {
  primary,
  secondary,
  facebook,
  google,
  warning,
  success,
}
