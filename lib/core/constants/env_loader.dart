// lib/core/constants/env_loader.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static Future<void> load() async {
    try {
      await dotenv.load(fileName: ".env");
      print('✅ .env file loaded successfully');
    } catch (e) {
      print('⚠️ Could not load .env file: $e');
      print('📝 Using default values');
      dotenv.testLoad(fileInput: '''
        APP_NAME=GoldTrack Vietnam
        APP_VERSION=1.0.0
        APP_ENV=dev
        API_BASE_URL_DEV=http://10.0.2.2:8001/api/v1
        API_BASE_URL_PROD=https://be-gold-track-vn.onrender.com/api/v1
        API_CONNECT_TIMEOUT=30
        API_RECEIVE_TIMEOUT=30
        ENABLE_LOCATION_SERVICES=true
        ENABLE_PUSH_NOTIFICATIONS=false
      ''');
    }
  }

  static String _getString(String key, {String fallback = ''}) {
    return dotenv.get(key, fallback: fallback).trim();
  }

  static String get apiBaseUrl {
    final env = _getString('APP_ENV', fallback: 'dev');
    if (env == 'prod') {
      return _getString('API_BASE_URL_PROD');
    }
    return _getString('API_BASE_URL_DEV');
  }

  static String get appName => _getString('APP_NAME', fallback: 'GoldTrack');

  static String get appVersion => _getString('APP_VERSION', fallback: '1.0.0');

  static int get connectTimeout =>
      int.tryParse(_getString('API_CONNECT_TIMEOUT', fallback: '30')) ?? 30;

  static int get receiveTimeout =>
      int.tryParse(_getString('API_RECEIVE_TIMEOUT', fallback: '30')) ?? 30;

  static bool get enableLocationServices =>
      _getString('ENABLE_LOCATION_SERVICES', fallback: 'true').toLowerCase() ==
      'true';

  static bool get enablePushNotifications =>
      _getString('ENABLE_PUSH_NOTIFICATIONS', fallback: 'true').toLowerCase() ==
      'true';

  static bool get isProduction =>
      _getString('APP_ENV', fallback: 'dev') == 'prod';

  static bool get isDevelopment =>
      _getString('APP_ENV', fallback: 'dev') == 'dev';
}
