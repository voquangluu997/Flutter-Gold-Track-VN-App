// lib/core/widgets/gradient_icon.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final LinearGradient? gradient;

  const GradientIcon(
    this.icon, {
    super.key,
    this.size = 24,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => (gradient ?? AppColors.etherealGradient).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}