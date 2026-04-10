// chirag_kit/lib/core/widgets/date/ck_date_field.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CKDateField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String dateFormat;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final ValueChanged<DateTime>? onDateSelected;
  final InputDecoration? decoration; // ✅ Custom decoration
  final ThemeData? datePickerTheme; // ✅ Custom date picker style

  const CKDateField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.dateFormat = 'dd-MM-yyyy',
    this.validator,
    this.onTap,
    this.onDateSelected,
    this.decoration,
    this.datePickerTheme,
  });

  // ─── Default Decoration ────────────────────────────────────
  InputDecoration get _defaultDecoration => InputDecoration(
    labelText: labelText,
    hintText: hintText,
    suffixIcon: const Icon(Icons.calendar_month),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: validator,
      onTap: onTap ?? () => _pickDate(context),
      // ✅ Custom decoration inject ho — warna default
      decoration: decoration ?? _defaultDecoration,
    );
  }

  // ─── Date Picker ───────────────────────────────────────────
  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      // ✅ Custom theme inject ho — warna Flutter default
      builder: datePickerTheme != null
          ? (context, child) => Theme(data: datePickerTheme!, child: child!)
          : null,
    );

    if (picked != null) {
      controller?.text = DateFormat(dateFormat).format(picked);
      onDateSelected?.call(picked);
    }
  }
}
