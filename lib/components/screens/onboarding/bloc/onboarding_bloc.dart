import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/onboarding/data/model/step_data.dart';
import 'package:health_plus/utils/local_storage.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

extension BlocExtension on BuildContext {
  OnboardingBloc get onboardingBloc => read<OnboardingBloc>();
}

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState.initial()) {
    on<OnboardingNextStep>(_onOnboardingNextStep);
  }

  void _onOnboardingNextStep(
    OnboardingNextStep event,
    Emitter<OnboardingState> emit,
  ) async {
    if (state.step + 1 == stepsData.length) {
      emit(state.copyWith(status: OnboardingStatus.finished));
      await LocalStorage.setFirstLaunch(false);
      return;
    }
    emit(state.copyWith(step: state.step + 1));
  }

  void jumpNextStep() {
    add(const OnboardingNextStep());
  }
}

const List<StepData> stepsData = [
  StepData(
    imagePath: AppResources.amicoInsurance,
    title: 'text.onboarding_title_1',
  ),
  StepData(
    imagePath: AppResources.amicoOnlineDoctor,
    title: 'text.onboarding_title_2',
  ),
  StepData(
    imagePath: AppResources.amicoPharmacist,
    title: 'text.onboarding_title_3',
  ),
];
