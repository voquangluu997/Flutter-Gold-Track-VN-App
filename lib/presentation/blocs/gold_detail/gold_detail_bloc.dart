// lib/presentation/blocs/gold_detail/gold_detail_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/gold_repository.dart';
import '../../../domain/usecases/get_gold_prices.dart';
import 'gold_detail_event.dart';
import 'gold_detail_state.dart';

class GoldDetailBloc extends Bloc<GoldDetailEvent, GoldDetailState> {
  final GetGoldPricesUseCase _getGoldPricesUseCase;
  final GetGoldHistoryUseCase _getGoldHistoryUseCase; 

  GoldDetailBloc(GoldRepository repository)
      : _getGoldPricesUseCase = GetGoldPricesUseCase(repository),
        _getGoldHistoryUseCase = GetGoldHistoryUseCase(repository),  
        super(GoldDetailInitial()) {
    on<LoadGoldDetail>(_onLoadGoldDetail);
    on<RefreshGoldDetail>(_onRefreshGoldDetail);
  }

  Future<void> _onLoadGoldDetail(
    LoadGoldDetail event,
    Emitter<GoldDetailState> emit,
  ) async {
    emit(GoldDetailLoading());
    try {
      // Gọi song song 2 API
      final results = await Future.wait([
        _getGoldPricesUseCase.execute(city: event.city, limit: 1),
        _getGoldHistoryUseCase.execute(brand: event.brand, city: event.city, days: 30),
      ]);

      final currentPrices = results[0];
      final historyPrices = results[1];

      final currentPrice = currentPrices.firstWhere(
        (p) => p.brand == event.brand,
        orElse: () => currentPrices.first,
      );

      emit(GoldDetailLoaded(
        currentPrice: currentPrice,
        historyPrices: historyPrices,
        lastUpdated: DateTime.now(),
      ));
    } catch (e) {
      emit(GoldDetailError(e.toString()));
    }
  }

  Future<void> _onRefreshGoldDetail(
    RefreshGoldDetail event,
    Emitter<GoldDetailState> emit,
  ) async {
    add(LoadGoldDetail(brand: event.brand, city: event.city));
  }
}