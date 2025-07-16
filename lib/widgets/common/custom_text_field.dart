import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final String? labelText;
  final EdgeInsets? contentPadding;
  final TextStyle? hintTextStyle;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.labelText,
    this.contentPadding,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        readOnly: readOnly,
        onTap: onTap,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        minLines: minLines,
        focusNode: focusNode,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: AppColors.secondaryLight.withValues(alpha: 0.2),
          contentPadding: contentPadding ?? 
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          hintStyle: hintTextStyle,
          
        ),
      ),
    );
  }
}
