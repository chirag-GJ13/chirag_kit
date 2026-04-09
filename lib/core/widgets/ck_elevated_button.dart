// lib/src/widgets/buttons/ck_elevated_button.dart

import 'package:flutter/material.dart';


/// A customizable elevated button from ChiragKit.
///
/// Usage:
/// ```dart
/// CKElevatedButton(
///   label: 'Click Me',
///   onPressed: () {},
/// )
/// ```
class CKElevatedBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CKElevatedBtn({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.borderRadius = 8.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(label,style: TextStyle(color: Colors.white),),
    );
  }
}