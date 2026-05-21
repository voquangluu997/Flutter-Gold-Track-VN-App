// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoldPriceModel _$GoldPriceModelFromJson(Map<String, dynamic> json) =>
    GoldPriceModel(
      id: json['id'] as String,
      brand: json['brand'] as String,
      city: json['city'] as String,
      buyPrice: (json['buyPrice'] as num).toInt(),
      sellPrice: (json['sellPrice'] as num).toInt(),
      type: json['type'] as String,
      source: json['source'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GoldPriceModelToJson(GoldPriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'city': instance.city,
      'buyPrice': instance.buyPrice,
      'sellPrice': instance.sellPrice,
      'type': instance.type,
      'source': instance.source,
      'createdAt': instance.createdAt.toIso8601String(),
    };
