class StringUtils {
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
  
  static String normalizeCity(String cityCode) {
    switch (cityCode.toLowerCase()) {
      case 'hanoi': return 'Hà Nội';
      case 'hcmc': return 'TP. Hồ Chí Minh';
      case 'danang': return 'Đà Nẵng';
      default: return cityCode;
    }
  }
}