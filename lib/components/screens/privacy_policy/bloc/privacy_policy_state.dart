part of 'privacy_policy_bloc.dart';

enum PrivacyPolicyStatus {
  initial,
  processing,
  loaded,
  warning,
  error,
}

class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState._({
    required this.status,
    required this.pages,
    this.error,
  });

  factory PrivacyPolicyState.initial() {
    return const PrivacyPolicyState._(
      status: PrivacyPolicyStatus.initial,
      pages: [],
    );
  }

  final PrivacyPolicyStatus status;
  final List<StaticPage> pages;
  final String? error;

  PrivacyPolicyState copyWith({
    PrivacyPolicyStatus? status,
    List<StaticPage>? pages,
    Nullable<String>? error,
  }) =>
      PrivacyPolicyState._(
        status: status ?? this.status,
        pages: pages ?? this.pages,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        pages,
        error,
      ];
}
