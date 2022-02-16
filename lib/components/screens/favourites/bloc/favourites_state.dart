part of 'favourites_bloc.dart';

enum FavouritesStatus {
  empty,
  fetching,
  loaded,
  error,
  warning,
}

class FavouritesState extends Equatable {
  const FavouritesState._({
    required this.status,
    required this.providers,
    this.error,
  });

  const FavouritesState.initial()
      : this._(
          status: FavouritesStatus.empty,
          providers: const [],
        );

  final FavouritesStatus status;
  final List<Provider> providers;
  final String? error;

  FavouritesState copyWith({
    FavouritesStatus? status,
    List<Provider>? providers,
    Nullable<String>? error,
  }) =>
      FavouritesState._(
        status: status ?? this.status,
        providers: providers ?? this.providers,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        providers,
        error,
      ];
}
