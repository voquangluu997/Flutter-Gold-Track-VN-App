import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart'; 

part 'exchange_rate_model.g.dart';

@JsonSerializable()
class ExchangeRateModel extends Equatable {
  final String id;
  final String currency;
  @JsonKey(name: 'buyPrice')
  final int buyPrice;
  @JsonKey(name: 'sellPrice')
  final int sellPrice;
  final String bank;
  final String source;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  const ExchangeRateModel({
    required this.id,
    required this.currency,
    required this.buyPrice,
    required this.sellPrice,
    required this.bank,
    required this.source,
    required this.createdAt,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateModelFromJson(json);

  @override
  List<Object?> get props => [id, currency, buyPrice, sellPrice];
}