// lib/data/repositories/gold_repository.dart
import '../datasources/remote/dio_client.dart';
import '../datasources/remote/gold_api_service.dart';
import '../models/gold_price_model.dart';

class GoldRepository {
  late final GoldApiService _apiService;

  GoldRepository() {
    final dioClient = DioClient();
    _apiService = GoldApiService(dioClient.dio);
  }

  Future<List<GoldPriceModel>> getLatestGoldPrices({
    String? city,
    int limit = 50,
  }) async {
    return await _apiService.getLatestGoldPrices(city: city, limit: limit);
  }

   Future<List<GoldPriceModel>> getGoldHistory({
    required String brand,
    required String city,
    int days = 30,
  }) async {
    return await _apiService.getGoldHistory(brand: brand, city: city, days: days);
  }
}