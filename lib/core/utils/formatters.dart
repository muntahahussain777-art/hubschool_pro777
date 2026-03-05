import 'package:intl/intl.dart';

class Fmt {
  static String money(int paisa) {
    final rupees = paisa / 100;
    return 'Rs ${NumberFormat('#,##0').format(rupees)}';
  }

  static String moneyInt(int rupees) {
    return 'Rs ${NumberFormat('#,##0').format(rupees)}';
  }

  static String date(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('dd MMM yyyy').format(dt);
  }

  static String dateTime(DateTime? dt) {
    if (dt == null) return '-';
    return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
  }

  static String monthKey(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}';
  }

  static String monthLabel(String key) {
    final parts = key.split('-');
    if (parts.length != 2) return key;
    final dt = DateTime(int.parse(parts[0]), int.parse(parts[1]));
    return DateFormat('MMMM yyyy').format(dt);
  }
}
