// lib/core/constants/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _Env.appName;

  @EnviedField(varName: 'APP_VERSION')
  static const String appVersion = _Env.appVersion;

  @EnviedField(varName: 'APP_ENV')
  static const String appEnv = _Env.appEnv;

  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'API_CONNECT_TIMEOUT')
  static const int apiConnectTimeout = _Env.apiConnectTimeout;

  @EnviedField(varName: 'API_RECEIVE_TIMEOUT')
  static const int apiReceiveTimeout = _Env.apiReceiveTimeout;

  @EnviedField(varName: 'LOCATION_ACCURACY')
  static const String locationAccuracy = _Env.locationAccuracy;

  @EnviedField(varName: 'LOCATION_DISTANCE_FILTER')
  static const int locationDistanceFilter = _Env.locationDistanceFilter;

  @EnviedField(varName: 'CACHE_EXPIRATION_DAYS')
  static const int cacheExpirationDays = _Env.cacheExpirationDays;

  @EnviedField(varName: 'CACHE_MAX_SIZE_MB')
  static const int cacheMaxSizeMB = _Env.cacheMaxSizeMB;

  @EnviedField(varName: 'ENABLE_LOCATION_SERVICES')
  static const bool enableLocationServices = _Env.enableLocationServices;

  @EnviedField(varName: 'ENABLE_PUSH_NOTIFICATIONS')
  static const bool enablePushNotifications = _Env.enablePushNotifications;

  @EnviedField(varName: 'ENABLE_ANALYTICS')
  static const bool enableAnalytics = _Env.enableAnalytics;

  @EnviedField(varName: 'DEFAULT_THEME')
  static const String defaultTheme = _Env.defaultTheme;

  @EnviedField(varName: 'LOG_LEVEL')
  static const String logLevel = _Env.logLevel;
}