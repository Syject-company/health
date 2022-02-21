part of 'plans_bloc.dart';

abstract class PlansEvent extends Equatable {
  const PlansEvent();

  @override
  List<Object> get props => [];
}

class LoadPlans extends PlansEvent {
  const LoadPlans();
}

class SelectPlan extends PlansEvent {
  const SelectPlan({required this.plan});

  final Plan plan;

  @override
  List<Object> get props => [plan];
}
