part of 'login_bloc.dart';

enum LoginStatus {
  unknown,
  input,
  processing,
  logged,
  error,
  warning,
}

class LoginState extends Equatable {
  const LoginState._({
    required this.email,
    required this.password,
    required this.status,
    this.error,
  });

  const LoginState.initial()
      : this._(
          email: '',
          password: '',
          status: LoginStatus.unknown,
        );

  final String email;
  final String password;
  final LoginStatus status;
  final String? error;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    Nullable<String>? error,
  }) =>
      LoginState._(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        error,
      ];
}
