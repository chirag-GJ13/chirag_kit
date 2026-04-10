// chirag_kit/lib/core/widgets/date/ck_time_field.dart

import 'package:flutter/material.dart';

class CKTimeField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TimeOfDay? initialTime;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final InputDecoration? decoration;
  final ThemeData? timePickerTheme;
  final bool use24HourFormat;

  const CKTimeField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialTime,
    this.validator,
    this.onTap,
    this.onTimeSelected,
    this.decoration,
    this.timePickerTheme,
    this.use24HourFormat = false,
  });

  // ─── Default Decoration ────────────────────────────────────
  InputDecoration get _defaultDecoration => InputDecoration(
    labelText: labelText,
    hintText: hintText,
    suffixIcon: const Icon(Icons.access_time),
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

  // ─── Format Time ───────────────────────────────────────────
  String _formatTime(TimeOfDay time) {
    if (use24HourFormat) {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    }
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final hours = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes $period';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: validator,
      onTap: onTap ?? () => _pickTime(context),
      decoration: decoration ?? _defaultDecoration,
    );
  }

  // ─── Time Picker ───────────────────────────────────────────
  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: timePickerTheme != null
          ? (context, child) => Theme(data: timePickerTheme!, child: child!)
          : null,
    );

    if (picked != null) {
      controller?.text = _formatTime(picked);
      onTimeSelected?.call(picked);
    }
  }
}
