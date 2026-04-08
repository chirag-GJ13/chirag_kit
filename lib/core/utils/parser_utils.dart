class Parser {
  static double toDouble(dynamic v, [double fb = 0.0]) {
    if (v == null) return fb;
    if (v is num) return v.toDouble();

    final cleaned = v
        .toString()
        .replaceAll('\u00A0', '') // NBSP
        .replaceAll(',', '') // comma
        .replaceAll('₹', '') // currency
        .trim();

    return double.tryParse(cleaned) ?? fb;
  }

  static int toInt(dynamic v, [int fb = 0]) {
    if (v == null) return fb;
    if (v is num) return v.toInt();

    final cleaned = v
        .toString()
        .replaceAll('\u00A0', '')
        .replaceAll(',', '')
        .replaceAll('₹', '')
        .trim();

    return int.tryParse(cleaned) ?? fb;
  }
}
