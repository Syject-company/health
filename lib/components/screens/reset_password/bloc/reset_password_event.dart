part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class InputEmail extends ResetPasswordEvent {
  const InputEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ResetPassword extends ResetPasswordEvent {
  const ResetPassword();
}
