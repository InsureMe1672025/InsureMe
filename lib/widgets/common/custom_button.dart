import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double height;
  final IconData? icon;
  final double borderRadius;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.width,
    this.height = 50.0,
    this.icon,
    this.borderRadius = 30.0,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textStyle?.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.0,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      );
    }

    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
  }
}
