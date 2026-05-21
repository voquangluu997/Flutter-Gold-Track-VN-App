class ApiConstants {
  // Endpoints
  static const String goldLatest = '/crawler/gold/latest';
  static const String goldHistory = '/crawler/gold/history';
  static const String currencyLatest = '/crawler/currency/latest';
  static const String triggerCrawl = '/crawler/trigger';
  static const String health = '/health';
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}