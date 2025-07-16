import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final String questionText;
  final String linkText;
  final VoidCallback onLinkTap;

  const AuthFooter({
    super.key,
    required this.questionText,
    required this.linkText,
    required this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questionText,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: onLinkTap,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              linkText,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
