part of 'change_password_bloc.dart';

enum ChangePasswordStatus {
  initial,
  input,
  processing,
  changed,
  error,
  warning,
}

class ChangePasswordState extends Equatable {
  const ChangePasswordState._({
    required this.status,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
    this.error,
  });

  const ChangePasswordState.initial()
      : this._(
          status: ChangePasswordStatus.initial,
          oldPassword: '',
          newPassword: '',
          confirmPassword: '',
        );

  final ChangePasswordStatus status;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final String? error;

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    Nullable<String>? error,
  }) =>
      ChangePasswordState._(
        status: status ?? this.status,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
        confirmPassword,
        status,
        error,
      ];
}
