part of 'offers_bloc.dart';

abstract class OffersEvent extends Equatable {
  const OffersEvent();

  @override
  List<Object> get props => [];
}

class LoadOffers extends OffersEvent {
  const LoadOffers();
}

class ClearOffers extends OffersEvent {
  const ClearOffers();
}