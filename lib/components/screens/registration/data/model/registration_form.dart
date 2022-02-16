import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/serializable.dart';

abstract class RegistrationFormFields {
  static const String email = 'email';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String password1 = 'password1';
  static const String password2 = 'password2';
}

class RegistrationForm extends Equatable implements JsonSerializable {
  const RegistrationForm({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password1,
    required this.password2,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String password1;
  final String password2;

  @override
  JsonMap toJson() {
    return {
      RegistrationFormFields.email: email,
      RegistrationFormFields.firstName: firstName,
      RegistrationFormFields.lastName: lastName,
      RegistrationFormFields.password1: password1,
      RegistrationFormFields.password2: password2,
    };
  }

  @override
  List<Object> get props => [
        email,
        firstName,
        lastName,
        password1,
        password2,
      ];
}
