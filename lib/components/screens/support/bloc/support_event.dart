part of 'support_bloc.dart';

abstract class SupportEvent extends Equatable {
  const SupportEvent();

  @override
  List<Object> get props => [];
}

class InputFullName extends SupportEvent {
  const InputFullName(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

class InputPhoneNumber extends SupportEvent {
  const InputPhoneNumber(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class InputEmail extends SupportEvent {
  const InputEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class InputSubject extends SupportEvent {
  const InputSubject(this.subject);

  final String subject;

  @override
  List<Object> get props => [subject];
}

class InputDescription extends SupportEvent {
  const InputDescription(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class SendMessage extends SupportEvent {
  const SendMessage();
}
