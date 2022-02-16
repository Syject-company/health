import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/model/plan.dart';

part 'plan_event.dart';
part 'plan_state.dart';

extension BlocExtension on BuildContext {
  PlanBloc get planBloc => read<PlanBloc>();
}

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({required Plan plan}) : super(PlanState.initial(plan));
}
