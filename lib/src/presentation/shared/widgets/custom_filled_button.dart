import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  //otros
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.text,
    this.buttonColor,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.borderRadius,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // const radius = Radius.circular(30);

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor ?? colorScheme.primary,
        padding:
            contentPadding ??
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),

        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ??
              const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
        ),
      ),

      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 8)],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: textColor ?? Colors.white,
            ),
          ),
          if (suffixIcon != null) ...[const SizedBox(width: 8), suffixIcon!],
        ],
      ),
    );
  }
}
