import 'package:equatable/equatable.dart';

abstract class GoldDetailEvent extends Equatable {
  const GoldDetailEvent();
  @override List<Object?> get props => [];
}

class LoadGoldDetail extends GoldDetailEvent {
  final String brand;
  final String city;
  const LoadGoldDetail({required this.brand, required this.city});
}

class RefreshGoldDetail extends GoldDetailEvent {
  final String brand;
  final String city;
  const RefreshGoldDetail({required this.brand, required this.city});
}