import 'package:equatable/equatable.dart';

class GoldPrice extends Equatable {
  final String id;
  final String brand;
  final String city;
  final int buyPrice;
  final int sellPrice;
  final String type;
  final DateTime createdAt;

  const GoldPrice({
    required this.id,
    required this.brand,
    required this.city,
    required this.buyPrice,
    required this.sellPrice,
    required this.type,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, brand, city, buyPrice, sellPrice];
}