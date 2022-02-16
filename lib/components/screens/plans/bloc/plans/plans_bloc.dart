import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/screens/plans/data/plans_page_service.dart';
import 'package:health_plus/locator.dart';
import 'package:health_plus/model/plan.dart';
import 'package:health_plus/utils/nullable.dart';

part 'plans_event.dart';
part 'plans_state.dart';

extension BlocExtension on BuildContext {
  PlansBloc get plansBloc => read<PlansBloc>();
}

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  PlansBloc() : super(PlansState.initial()) {
    on<LoadPlans>(_onLoadPlans);
    on<SelectPlan>(_onSelectPlan);

    add(const LoadPlans());
  }

  final PlanService _planService = locator<PlanService>();

  Future<void> _onLoadPlans(
    LoadPlans event,
    Emitter<PlansState> emit,
  ) async {
    try {
      emit(state.copyWith(status: PlansStatus.fetching));

      final getAllPlansResponse = await _planService.getAll();
      getAllPlansResponse.onSuccess((data) {
        if (data != null) {
          emit(state.copyWith(
            status: PlansStatus.loaded,
            plans: data.results,
            error: Nullable(null),
          ));
        }
      });
      getAllPlansResponse.handle();
    } catch (e) {
      emit(state.copyWith(
        status: PlansStatus.warning,
        error: Nullable('Something went wrong.'),
      ));
      throw Exception(e);
    }
  }

  Future<void> _onSelectPlan(
    SelectPlan event,
    Emitter<PlansState> emit,
  ) async {
    emit(state.copyWith(
      selectedPlan: Nullable(event.plan),
    ));
  }

  void selectPlan(Plan plan) {
    add(SelectPlan(plan: plan));
  }
}
