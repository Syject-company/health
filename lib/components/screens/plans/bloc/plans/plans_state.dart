part of 'plans_bloc.dart';

enum PlansStatus {
  empty,
  fetching,
  loaded,
  error,
  warning,
}

class PlansState extends Equatable {
  const PlansState._({
    required this.status,
    required this.plans,
    this.selectedPlan,
    this.error,
  });

  factory PlansState.initial() {
    return const PlansState._(
      status: PlansStatus.empty,
      plans: [],
    );
  }

  final PlansStatus status;
  final List<Plan> plans;
  final Plan? selectedPlan;
  final String? error;

  PlansState copyWith({
    PlansStatus? status,
    List<Plan>? plans,
    Nullable<Plan>? selectedPlan,
    Nullable<String>? error,
  }) =>
      PlansState._(
        status: status ?? this.status,
        plans: plans ?? this.plans,
        selectedPlan:
            selectedPlan != null ? selectedPlan.value : this.selectedPlan,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        plans,
        selectedPlan,
        error,
      ];
}
