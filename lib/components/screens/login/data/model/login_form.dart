import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/serializable.dart';

abstract class LoginFormFields {
  static const String email = 'email';
  static const String password = 'password';
}

class LoginForm extends Equatable implements JsonSerializable {
  const LoginForm({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  JsonMap toJson() {
    return {
      LoginFormFields.email: email,
      LoginFormFields.password: password,
    };
  }

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
