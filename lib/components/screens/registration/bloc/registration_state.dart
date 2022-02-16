part of 'registration_bloc.dart';

enum RegistrationStatus {
  unknown,
  input,
  processing,
  registered,
  error,
}

class RegistrationState extends Equatable {
  const RegistrationState._({
    required this.status,
    required this.fullName,
    required this.email,
    required this.password,
    this.error,
  });

  const RegistrationState.initial()
      : this._(
          status: RegistrationStatus.unknown,
          fullName: '',
          email: '',
          password: '',
        );

  final String fullName;
  final String email;
  final String password;
  final RegistrationStatus status;
  final String? error;

  RegistrationState copyWith({
    RegistrationStatus? status,
    String? fullName,
    String? email,
    String? password,
    Nullable<String>? error,
  }) =>
      RegistrationState._(
        status: status ?? this.status,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        fullName,
        email,
        password,
        error,
      ];
}
