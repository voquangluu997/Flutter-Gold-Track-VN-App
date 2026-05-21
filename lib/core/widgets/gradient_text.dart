// lib/core/widgets/gradient_text.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final TextStyle? style;
  final String? fontFamily;
  final double? letterSpacing;
  final double? height;

  const GradientText(
    this.text, {
    super.key,
    this.fontSize = 24,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    this.fontFamily,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ??
        TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing,
          height: height,
          color: Colors.white,
        );

    return ShaderMask(
      shaderCallback: (bounds) => AppColors.etherealGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: baseStyle,
      ),
    );
  }
}