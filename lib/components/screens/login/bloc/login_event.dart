part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InputEmail extends LoginEvent {
  const InputEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class InputPassword extends LoginEvent {
  const InputPassword(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class Login extends LoginEvent {
  const Login();
}