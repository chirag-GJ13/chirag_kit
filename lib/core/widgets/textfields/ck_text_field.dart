import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CKTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final bool isRequired;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autovalidateMode;
  final InputDecoration? decoration;
  final double borderRadius;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;

  const CKTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.decoration,
    this.borderRadius = 8,
    this.labelStyle,
    this.contentPadding,
  });

  // ─── Default Decoration ────────────────────────────────────
  InputDecoration _defaultDecoration() => InputDecoration(
    hintText: hint,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    counterText: '',
    contentPadding:
        contentPadding ??
        EdgeInsets.symmetric(
          horizontal: 4.w, // ✅ Sizer
          vertical: 1.5.h, // ✅ Sizer
        ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.black, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
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
                TextStyle(
                  fontSize: 11.sp, // ✅ Sizer
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 0.8.h), // ✅ Sizer
        ],

        // ─── Field ─────────────────────────────────────────
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          autovalidateMode: autovalidateMode,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          decoration: decoration ?? _defaultDecoration(),
        ),

        SizedBox(height: 2.h), // ✅ Sizer
      ],
    );
  }
}
