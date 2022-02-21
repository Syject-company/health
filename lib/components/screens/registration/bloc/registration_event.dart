part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class InputFullName extends RegistrationEvent {
  const InputFullName(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

class InputEmail extends RegistrationEvent {
  const InputEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class InputPassword extends RegistrationEvent {
  const InputPassword(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class Register extends RegistrationEvent {
  const Register();
}
