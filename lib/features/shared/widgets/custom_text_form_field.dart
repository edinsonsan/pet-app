import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  // Nuevos parámetros para estilos personalizados
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? hintStyle;
  final TextStyle? floatingLabelStyle;
  final List<BoxShadow>? boxShadow;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.backgroundColor,
    this.textColor,
    this.hintStyle,
    this.floatingLabelStyle,
    this.boxShadow,
    this.prefixIcon,
    this.suffixIcon,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    const borderRadius = Radius.circular(30);

    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: borderRadius,
          bottomLeft: borderRadius,
          bottomRight: borderRadius,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 20,
          color: textColor ?? colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          floatingLabelStyle:
              floatingLabelStyle ??
              TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.red.shade800),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.red.shade800),
          ),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          hintStyle: hintStyle ?? TextStyle(color: colorScheme.outline),
          errorText: errorMessage,
          focusColor: colorScheme.primary,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
