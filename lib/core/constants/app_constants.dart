// lib/core/constants/app_constants.dart
import 'env_loader.dart';

class AppConstants {
  // App Info
  static String get appName => EnvLoader.appName;
  static String get appVersion => EnvLoader.appVersion;
  static bool get isProduction => EnvLoader.isProduction;
  static bool get isDevelopment => EnvLoader.isDevelopment;
  
  // API
  static String get baseUrl => EnvLoader.apiBaseUrl;
  static Duration get connectTimeout => Duration(seconds: EnvLoader.connectTimeout);
  static Duration get receiveTimeout => Duration(seconds: EnvLoader.receiveTimeout);
  
  // Features
  static bool get enableLocationServices => EnvLoader.enableLocationServices;
  static bool get enablePushNotifications => EnvLoader.enablePushNotifications;
  
  // API Endpoints
  static const String goldLatest = '/crawler/gold/latest';
  static const String goldHistory = '/crawler/gold/history';
  static const String currencyLatest = '/crawler/currency/latest';
  static const String triggerCrawl = '/crawler/trigger';
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}