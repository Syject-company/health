part of 'onboarding_bloc.dart';

enum OnboardingStatus {
  initial,
  finished,
}

class OnboardingState extends Equatable {
  const OnboardingState._({
    required this.status,
    required this.step,
  });

  const OnboardingState.initial()
      : this._(
          status: OnboardingStatus.initial,
          step: 0,
        );

  final OnboardingStatus status;
  final int step;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? step,
  }) =>
      OnboardingState._(
        status: status ?? this.status,
        step: step ?? this.step,
      );

  @override
  List<Object> get props => [
        stepsData,
        status,
        step,
      ];
}
