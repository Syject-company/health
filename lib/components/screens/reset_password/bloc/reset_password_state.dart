part of 'reset_password_bloc.dart';

enum ResetPasswordStatus {
  initial,
  input,
  processing,
  sent,
  error,
}

class ResetPasswordState extends Equatable {
  const ResetPasswordState._({
    required this.status,
    required this.email,
    this.error,
  });

  const ResetPasswordState.initial()
      : this._(
          email: '',
          status: ResetPasswordStatus.initial,
        );

  final ResetPasswordStatus status;
  final String email;
  final String? error;

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? email,
    Nullable<String>? error,
  }) =>
      ResetPasswordState._(
        status: status ?? this.status,
        email: email ?? this.email,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        email,
        error,
      ];
}
