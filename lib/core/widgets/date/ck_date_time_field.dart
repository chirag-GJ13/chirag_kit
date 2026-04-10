// chirag_kit/lib/core/widgets/date/ck_date_time_field.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CKDateTimeField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String dateFormat;
  final bool use24HourFormat;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final ValueChanged<DateTime>? onDateTimeSelected;
  final InputDecoration? decoration;
  final ThemeData? pickerTheme;

  const CKDateTimeField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.dateFormat = 'dd-MM-yyyy hh:mm a',
    this.use24HourFormat = false,
    this.validator,
    this.onTap,
    this.onDateTimeSelected,
    this.decoration,
    this.pickerTheme,
  });

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
      onTap: onTap ?? () => _pickDateTime(context),
      decoration: decoration ?? _defaultDecoration,
    );
  }

  // ─── Date + Time — Step by Step ────────────────────────────
  Future<void> _pickDateTime(BuildContext context) async {
    // Step 1 — Date pick karo
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      builder: pickerTheme != null
          ? (context, child) => Theme(data: pickerTheme!, child: child!)
          : null,
    );

    if (pickedDate == null) return; // User ne cancel kiya

    // Step 2 — Time pick karo
    if (!context.mounted) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: pickerTheme != null
          ? (context, child) => Theme(data: pickerTheme!, child: child!)
          : null,
    );

    if (pickedTime == null) return;

    // Step 3 — Combine karo
    final combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    controller?.text = DateFormat(dateFormat).format(combined);
    onDateTimeSelected?.call(combined);
  }
}
