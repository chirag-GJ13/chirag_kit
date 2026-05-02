import 'package:flutter/material.dart';

class AnimatedCount extends StatelessWidget {
  final double value;
  final Color color;
  final bool isBold;
  final double fontSize;
  final String? prefix;
  final String? suffix;
  final Duration duration;
  final TextStyle? style;

  const AnimatedCount({
    super.key,
    required this.value,
    required this.color,
    this.isBold = false,
    this.fontSize = 24,
    this.prefix,
    this.suffix,
    this.duration = const Duration(seconds: 2),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, val, _) {
        final display = [
          if (prefix != null) prefix!,
          val.toInt().toString(),
          if (suffix != null) suffix!,
        ].join();

        return Text(
          display,
          style:
              style ??
              TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                color: color,
                height: 1,
              ),
        );
      },
    );
  }
}
