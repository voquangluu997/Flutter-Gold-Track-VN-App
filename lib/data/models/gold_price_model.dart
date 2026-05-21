import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gold_price_model.g.dart';

@JsonSerializable()
class GoldPriceModel extends Equatable {
  final String id;
  final String brand;
  final String city;
  @JsonKey(name: 'buyPrice')
  final int buyPrice;
  @JsonKey(name: 'sellPrice')
  final int sellPrice;
  final String type;
  final String source;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  const GoldPriceModel({
    required this.id,
    required this.brand,
    required this.city,
    required this.buyPrice,
    required this.sellPrice,
    required this.type,
    required this.source,
    required this.createdAt,
  });

  factory GoldPriceModel.fromJson(Map<String, dynamic> json) =>
      _$GoldPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoldPriceModelToJson(this);

  @override
  List<Object?> get props => [id, brand, city, buyPrice, sellPrice];
}