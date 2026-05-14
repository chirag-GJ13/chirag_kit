import 'package:intl/intl.dart';

class DateUtils {
  /// Format DateTime → String
  static String format(DateTime? date, {String pattern = 'dd MMM yyyy'}) {
    if (date == null) return '';
    return DateFormat(pattern).format(date);
  }

  /// Format from String → String
  static String formatFromString(
    String? dateString, {
    String inputPattern = "yyyy-MM-dd",
    String outputPattern = "dd MMM yyyy",
  }) {
    if (dateString == null || dateString.isEmpty) return '';

    try {
      final parsedDate = DateFormat(inputPattern).parse(dateString);
      return DateFormat(outputPattern).format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Format DateTime → Time (HH:mm)
  static String formatTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('hh:mm a').format(date);
  }

  /// API date → readable (2026-03-18T10:00:00.000Z)
  static String formatApiDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';

    try {
      final parsed = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsed);
    } catch (e) {
      return '';
    }
  }

  /// Today / Yesterday logic
  static String formatSmart(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }
}
