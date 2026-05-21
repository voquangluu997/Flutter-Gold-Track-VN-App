import 'package:intl/intl.dart';

class PriceFormatter {
  static final NumberFormat _formatter = NumberFormat('#,###', 'vi_VN');
  
  static String format(int price) {
    return '${_formatter.format(price)} ₫';
  }
  
  static String formatCompact(int price) {
    if (price >= 1_000_000_000) {
      return '${(price / 1_000_000_000).toStringAsFixed(1)} tỷ';
    } else if (price >= 1_000_000) {
      return '${(price / 1_000_000).toStringAsFixed(1)} tr';
    }
    return format(price);
  }
}