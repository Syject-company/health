import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class RegistrationResponseFields {
  static const String email = 'email';
}

class RegistrationResponse extends Equatable {
  const RegistrationResponse({
    required this.email,
  });

  final String email;

  static RegistrationResponse fromJson(JsonMap json) {
    return RegistrationResponse(
      email: json[RegistrationResponseFields.email],
    );
  }

  @override
  List<Object> get props => [email];
}
