import '../../data/repositories/gold_repository.dart';
import '../entities/gold_price.dart';

class GetGoldPricesUseCase {
  final GoldRepository _repository;

  GetGoldPricesUseCase(this._repository);

  Future<List<GoldPrice>> execute({String? city, int limit = 50}) async {
    final models = await _repository.getLatestGoldPrices(city: city, limit: limit);
    return models.map((model) => GoldPrice(
      id: model.id,
      brand: model.brand,
      city: model.city,
      buyPrice: model.buyPrice,
      sellPrice: model.sellPrice,
      type: model.type,
      createdAt: model.createdAt,
    )).toList();
  }
}

class GetGoldHistoryUseCase {
  final GoldRepository _repository;
  GetGoldHistoryUseCase(this._repository);
  Future<List<GoldPrice>> execute({
    required String brand,
    required String city,
    int days = 30,
  }) async {
    final models = await _repository.getGoldHistory(brand: brand, city: city, days: days);
    return models.map((model) => GoldPrice(
      id: model.id,
      brand: model.brand,
      city: model.city,
      buyPrice: model.buyPrice,
      sellPrice: model.sellPrice,
      type: model.type,
      createdAt: model.createdAt,
    )).toList();
  }
}