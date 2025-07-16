import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  
  const AppLogo({
    super.key, 
    this.size = 80.0,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Image.asset(
            'assets/images/logostartpage.png',
            width: size * 0.6,
            height: size * 0.6,
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 16),
          Text(
            'InsureMe',
            style: TextStyle(
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            'Your Protection Partner',
            style: TextStyle(
              fontSize: size * 0.2,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
