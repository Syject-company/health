part of 'offers_bloc.dart';

enum OffersStatus {
  empty,
  fetching,
  loaded,
  error,
  warning,
}

class OffersState extends Equatable {
  const OffersState._({
    required this.status,
    required this.promotions,
    this.error,
  });

  const OffersState.initial()
      : this._(
          status: OffersStatus.empty,
          promotions: const [],
        );

  final OffersStatus status;
  final List<Promotion> promotions;
  final String? error;

  OffersState copyWith({
    OffersStatus? status,
    List<Promotion>? promotions,
    Nullable<String>? error,
  }) =>
      OffersState._(
        status: status ?? this.status,
        promotions: promotions ?? this.promotions,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        promotions,
        error,
      ];
}
