import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CKStaticDropdown<T> extends StatelessWidget {
  final String? label;
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemAsString;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final FocusNode? focusNode;
  final bool isRequired;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final InputDecoration? decoration;
  final double borderRadius;

  const CKStaticDropdown({
    super.key,
    this.label,
    required this.hint,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
    this.value,
    this.validator,
    this.focusNode,
    this.isRequired = false,
    this.labelStyle,
    this.hintStyle,
    this.itemStyle,
    this.decoration,
    this.borderRadius = 8,
  });

  InputDecoration _defaultDecoration() => InputDecoration(
    hintText: hint,
    hintStyle: hintStyle ?? TextStyle(fontSize: 11.sp, color: Colors.grey),
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
                TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 1.h),
        ],

        // ─── Dropdown ──────────────────────────────────────
        Focus(
          focusNode: focusNode,
          child: DropdownButtonFormField<T>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            isExpanded: true,
            isDense: true,
            value: value,
            decoration: decoration ?? _defaultDecoration(),
            hint: Text(
              hint,
              style:
                  hintStyle ?? TextStyle(fontSize: 11.sp, color: Colors.grey),
            ),
            items: items
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e,
                    child: Text(
                      itemAsString(e),
                      style: itemStyle ?? TextStyle(fontSize: 11.sp),
                    ),
                  ),
                )
                .toList(),
            validator: validator,
            onChanged: (v) {
              FocusScope.of(context).unfocus();
              onChanged(v);
            },
          ),
        ),

        SizedBox(height: 2.h),
      ],
    );
  }
}
