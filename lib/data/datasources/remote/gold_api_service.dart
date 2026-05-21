import 'package:dio/dio.dart';
import '../../models/gold_price_model.dart';
import '../../../core/constants/api_constants.dart';

class GoldApiService {
  final Dio _dio; 
  GoldApiService(this._dio);  

  Future<List<GoldPriceModel>> getLatestGoldPrices({
    String? city,
    int? limit,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.goldLatest,
        queryParameters: {
          if (city != null) 'city': city,
          if (limit != null) 'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => GoldPriceModel.fromJson(json)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Connection error: ${e.message}');
    }
  }

  Future<List<GoldPriceModel>> getGoldHistory({
    required String brand,
    required String city,
    int days = 30,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.goldHistory,
        queryParameters: {
          'brand': brand,
          'city': city,
          'days': days,
        },
      );

      print('📡 API Response: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        
        if (responseData.containsKey('data') && responseData['data'] is List) {
          final List dataList = responseData['data'];
          
          return dataList.map((item) {
            return GoldPriceModel(
              id: '${brand}_${item['date']}',
              brand: brand,
              city: city,
              buyPrice: (item['buy'] as num).toInt(),
              sellPrice: (item['sell'] as num).toInt(),
              type: '9999',
              source: 'api',
              createdAt: DateTime.parse(item['date']),
            );
          }).toList();
        }
        return [];
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      throw Exception('Connection error: ${e.message}');
    } catch (e) {
      print('❌ Parse error: $e');
      throw Exception('Parse error: $e');
    }
  }
}