// lib/data/datasources/remote/dio_client.dart
import 'package:dio/dio.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/api_constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: ApiConstants.headers,
    ));
    
    _addInterceptors();
  }
  
  void _addInterceptors() {
    if (AppConstants.isDevelopment) {
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🚀 Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('❌ Error: ${error.message}');
          return handler.next(error);
        },
      ));
    }
  }
  
  Dio get dio => _dio;
}