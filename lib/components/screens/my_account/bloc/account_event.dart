part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class InitializeProfile extends AccountEvent {
  const InitializeProfile({required this.profile});

  final Profile profile;

  @override
  List<Object> get props => [profile];
}

class LoadProfile extends AccountEvent {
  const LoadProfile();
}

class UpdateProfile extends AccountEvent {
  const UpdateProfile({required this.profile});

  final Profile profile;

  @override
  List<Object> get props => [profile];
}

class ClearProfile extends AccountEvent {
  const ClearProfile();
}
