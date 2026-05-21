import 'package:equatable/equatable.dart';
import '../../../domain/entities/gold_price.dart';

abstract class GoldState extends Equatable {
  const GoldState();
  @override List<Object?> get props => [];
}

class GoldInitial extends GoldState {}
class GoldLoading extends GoldState {}

class GoldLoaded extends GoldState {
  final List<GoldPrice> goldPrices;
  final String currentCity;
  final DateTime lastUpdated;
  final bool isLoading;

  const GoldLoaded({
    required this.goldPrices,
    required this.currentCity,
    required this.lastUpdated,
    this.isLoading = false,
  });

  GoldLoaded copyWith({
    List<GoldPrice>? goldPrices,
    String? currentCity,
    DateTime? lastUpdated,
    bool? isLoading,
  }) {
    return GoldLoaded(
      goldPrices: goldPrices ?? this.goldPrices,
      currentCity: currentCity ?? this.currentCity,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [goldPrices, currentCity, lastUpdated, isLoading];
}

class GoldError extends GoldState {
  final String message;
  const GoldError(this.message);
}