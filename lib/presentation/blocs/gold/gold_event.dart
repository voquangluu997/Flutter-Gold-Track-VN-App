import 'package:equatable/equatable.dart';

abstract class GoldEvent extends Equatable {
  const GoldEvent();
  @override List<Object?> get props => [];
}

class LoadGoldPrices extends GoldEvent {
  final String? city;
  const LoadGoldPrices({this.city});
}

class RefreshGoldPrices extends GoldEvent {
  final String? city;
  const RefreshGoldPrices({this.city});
}

class ChangeCity extends GoldEvent {
  final String city;
  const ChangeCity(this.city);
}