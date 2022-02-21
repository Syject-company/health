part of 'personal_data_bloc.dart';

abstract class PersonalDataEvent extends Equatable {
  const PersonalDataEvent();

  @override
  List<Object> get props => [];
}

class InputFullName extends PersonalDataEvent {
  const InputFullName(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

class InputPhoneNumber extends PersonalDataEvent {
  const InputPhoneNumber(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class InputEmail extends PersonalDataEvent {
  const InputEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PickAvatar extends PersonalDataEvent {
  const PickAvatar(this.imagePath);

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class SaveData extends PersonalDataEvent {
  const SaveData();
}
