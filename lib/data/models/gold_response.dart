import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'gold_price_model.dart';

part 'gold_response.g.dart';

@JsonSerializable()
class GoldListResponse extends Equatable {
  final List<GoldPriceModel> data;
  final PaginationInfo? pagination;

  const GoldListResponse({
    required this.data,
    this.pagination,
  });

  factory GoldListResponse.fromJson(Map<String, dynamic> json) =>
      _$GoldListResponseFromJson(json);

  @override
  List<Object?> get props => [data, pagination];
}

@JsonSerializable()
class PaginationInfo extends Equatable {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  const PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  @override
  List<Object?> get props => [page, limit, total, totalPages, hasNext, hasPrev];
}