import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CKTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool isRequired;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;
  final InputDecoration? decoration;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final double borderRadius;
  final AutovalidateMode autovalidateMode;

  const CKTextField({
    super.key,
    this.label,
    this.hint,
    required this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.isRequired = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.decoration,
    this.labelStyle,
    this.hintStyle,
    this.borderRadius = 10,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  // ─── Default Decoration ────────────────────────────────────
  InputDecoration _defaultDecoration() => InputDecoration(
    hintText: hint,
    hintStyle: hintStyle ?? TextStyle(fontSize: 13, color: Colors.grey),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    counterText: '',
    errorStyle: const TextStyle(color: Colors.red),
    contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Label ─────────────────────────────────────────
        if (label != null && label!.trim().isNotEmpty) ...[
          Text(
            isRequired ? '$label *' : label!,
            style:
                labelStyle ??
                TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 1.h),
        ],

        // ─── Field ─────────────────────────────────────────
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          maxLength: maxLength,
          readOnly: readOnly,
          onTap: onTap,
          autovalidateMode: autovalidateMode,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          validator: validator,
          onChanged: onChanged,
          decoration: decoration ?? _defaultDecoration(),
        ),

        SizedBox(height: 2.h),
      ],
    );
  }
}
