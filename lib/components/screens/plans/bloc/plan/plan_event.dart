part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class LoadPlans extends PlanEvent {
  const LoadPlans();
}

class SelectPlan extends PlanEvent {
  const SelectPlan({required this.plan});

  final Plan plan;

  @override
  List<Object> get props => [plan];
}
