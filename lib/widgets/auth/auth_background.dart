import 'dart:math' show sin;

import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final String? backgroundImage;
  final Color? backgroundColor;

  const AuthBackground({
    super.key,
    required this.child,
    this.backgroundImage,
    this.backgroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background with gradient and wave pattern
          Container(
            decoration: BoxDecoration(
              image: backgroundImage != null
                ? DecorationImage(
                    image: AssetImage(backgroundImage!),
                    fit: BoxFit.cover,
                  )
                : null,
              gradient: backgroundImage == null ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary,
                  AppColors.primaryLight,
                ],
              ) : null,
            ),
          ),
          
        
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 
                    MediaQuery.of(context).padding.top - 
                    MediaQuery.of(context).padding.bottom,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Color color;
  final double waveHeight;
  final double frequency;
  final bool reverse;

  WavePainter({
    required this.color,
    required this.waveHeight,
    required this.frequency,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Start at the left edge
    path.moveTo(0, reverse ? 0 : size.height);
    
    // Draw the wave
    for (double i = 0; i <= size.width; i++) {
      final x = i;
      final y = reverse
          ? sin((i / size.width) * 2 * pi * frequency) * waveHeight + waveHeight
          : size.height - sin((i / size.width) * 2 * pi * frequency) * waveHeight - waveHeight;
      path.lineTo(x, y);
    }
    
    // Complete the path
    if (reverse) {
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    }
    
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Helper to get pi value
const double pi = 3.1415926535897932;
