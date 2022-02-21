part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavourites extends FavouritesEvent {
  const LoadFavourites();
}

class AddToFavourites extends FavouritesEvent {
  const AddToFavourites({required this.provider});

  final Provider provider;

  @override
  List<Object> get props => [provider];
}

class RemoveFromFavourites extends FavouritesEvent {
  const RemoveFromFavourites({required this.provider});

  final Provider provider;

  @override
  List<Object> get props => [provider];
}

class ClearFavourites extends FavouritesEvent {
  const ClearFavourites();
}