part of 'privacy_policy_bloc.dart';

abstract class PrivacyPolicyEvent extends Equatable {
  const PrivacyPolicyEvent();

  @override
  List<Object> get props => [];
}

class LoadPages extends PrivacyPolicyEvent {
  const LoadPages();
}
