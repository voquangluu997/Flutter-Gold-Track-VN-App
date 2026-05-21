// lib/presentation/blocs/gold_detail/gold_detail_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/gold_price.dart';

abstract class GoldDetailState extends Equatable {
  const GoldDetailState();
  @override List<Object?> get props => [];
}

class GoldDetailInitial extends GoldDetailState {}
class GoldDetailLoading extends GoldDetailState {}

class GoldDetailLoaded extends GoldDetailState {
  final GoldPrice currentPrice;
  final List<GoldPrice> historyPrices;  
  final DateTime lastUpdated;

  const GoldDetailLoaded({
    required this.currentPrice,
    required this.historyPrices,
    required this.lastUpdated,
  });

  List<GoldPrice> get recentPrices {
    if (historyPrices.length <= 7) return historyPrices;
    return historyPrices.sublist(historyPrices.length - 7);
  }

  double get highestPrice {
    if (historyPrices.isEmpty) {
      return currentPrice.sellPrice.toDouble();
    }
    return historyPrices
        .map((p) => p.sellPrice.toDouble())
        .reduce((a, b) => a > b ? a : b);
  }

  double get lowestPrice {
    if (historyPrices.isEmpty) {
      return currentPrice.sellPrice.toDouble();
    }
    return historyPrices
        .map((p) => p.sellPrice.toDouble())
        .reduce((a, b) => a < b ? a : b);
  }

  double get averagePrice {
    if (historyPrices.isEmpty) {
      return currentPrice.sellPrice.toDouble();
    }
    final sum = historyPrices.map((p) => p.sellPrice).reduce((a, b) => a + b);
    return sum / historyPrices.length;
  }

  @override
  List<Object?> get props => [currentPrice, historyPrices, lastUpdated];
}

class GoldDetailError extends GoldDetailState {
  final String message;
  const GoldDetailError(this.message);
}