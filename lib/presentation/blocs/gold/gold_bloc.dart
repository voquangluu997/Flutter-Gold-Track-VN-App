import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/gold_repository.dart';
import '../../../domain/usecases/get_gold_prices.dart';
import 'gold_event.dart';
import 'gold_state.dart';

// import '../../../data/services/location_service.dart';

class GoldBloc extends Bloc<GoldEvent, GoldState> {
  final GetGoldPricesUseCase _getGoldPricesUseCase;
  
  String _currentCity = 'Hanoi';

  GoldBloc(GoldRepository repository)
      : _getGoldPricesUseCase = GetGoldPricesUseCase(repository),
        super(GoldInitial()) {
    on<LoadGoldPrices>(_onLoadGoldPrices);
    on<RefreshGoldPrices>(_onRefreshGoldPrices);
    on<ChangeCity>(_onChangeCity);
  }

  Future<void> _onLoadGoldPrices(
    LoadGoldPrices event,
    Emitter<GoldState> emit,
  ) async {
    emit(GoldLoading());
    try {
      final city = event.city ?? _currentCity;
      
      // if (event.city == null) {
      //   city = await LocationService.getCurrentCity();
      // }
      
      final prices = await _getGoldPricesUseCase.execute(city: city, limit: 50);
      emit(GoldLoaded(
        goldPrices: prices,
        currentCity: city,
        lastUpdated: DateTime.now(),
      ));
    } catch (e) {
      emit(GoldError(e.toString()));
    }
  }

  Future<void> _onRefreshGoldPrices(
    RefreshGoldPrices event,
    Emitter<GoldState> emit,
  ) async {
    add(LoadGoldPrices(city: event.city));
  }

  Future<void> _onChangeCity(
    ChangeCity event,
    Emitter<GoldState> emit,
  ) async {
    _currentCity = event.city;
    add(LoadGoldPrices(city: event.city));
  }
}