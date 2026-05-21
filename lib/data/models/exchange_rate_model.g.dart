// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateModel _$ExchangeRateModelFromJson(Map<String, dynamic> json) =>
    ExchangeRateModel(
      id: json['id'] as String,
      currency: json['currency'] as String,
      buyPrice: (json['buyPrice'] as num).toInt(),
      sellPrice: (json['sellPrice'] as num).toInt(),
      bank: json['bank'] as String,
      source: json['source'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ExchangeRateModelToJson(ExchangeRateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currency': instance.currency,
      'buyPrice': instance.buyPrice,
      'sellPrice': instance.sellPrice,
      'bank': instance.bank,
      'source': instance.source,
      'createdAt': instance.createdAt.toIso8601String(),
    };
