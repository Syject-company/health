part of 'support_bloc.dart';

enum SupportStatus {
  initial,
  input,
  processing,
  sent,
  error,
  warning,
}

class SupportState extends Equatable {
  const SupportState._({
    required this.status,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.subject,
    required this.description,
    this.error,
  });

  factory SupportState.initial(Profile profile) {
    return SupportState._(
      status: SupportStatus.initial,
      fullName: '${profile.firstName} ${profile.lastName}'.trim(),
      phoneNumber: profile.phoneNumber,
      email: profile.email,
      subject: '',
      description: '',
    );
  }

  final SupportStatus status;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String subject;
  final String description;
  final String? error;

  SupportState copyWith({
    SupportStatus? status,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? subject,
    String? description,
    Nullable<String>? error,
  }) =>
      SupportState._(
        status: status ?? this.status,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        fullName,
        phoneNumber,
        email,
        subject,
        description,
        error,
      ];
}
