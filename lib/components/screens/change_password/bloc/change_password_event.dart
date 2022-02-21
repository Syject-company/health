part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class InputOldPassword extends ChangePasswordEvent {
  const InputOldPassword(this.oldPassword);

  final String oldPassword;

  @override
  List<Object> get props => [oldPassword];
}

class InputNewPassword extends ChangePasswordEvent {
  const InputNewPassword(this.newPassword);

  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

class InputConfirmPassword extends ChangePasswordEvent {
  const InputConfirmPassword(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class SaveChanges extends ChangePasswordEvent {
  const SaveChanges();
}
