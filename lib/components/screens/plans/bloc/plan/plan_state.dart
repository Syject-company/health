part of 'plan_bloc.dart';

class PlanState extends Equatable {
  const PlanState._({required this.plan});

  factory PlanState.initial(Plan plan) {
    return PlanState._(plan: plan);
  }

  final Plan plan;

  @override
  List<Object> get props => [plan];
}
