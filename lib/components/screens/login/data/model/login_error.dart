import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class LoginErrorFields {
  static const String emailErrors = 'email';
  static const String passwordErrors = 'password';
  static const String nonFieldErrors = 'non_field_errors';
}

class LoginError extends Equatable {
  const LoginError({
    required this.emailErrors,
    required this.passwordErrors,
    required this.nonFieldErrors,
  });

  final List<String>? emailErrors;
  final List<String>? passwordErrors;
  final List<String>? nonFieldErrors;

  static LoginError fromJson(JsonMap json) {
    List<String> parseList<T>(dynamic data) {
      return List<String>.from((data as Iterable).map((str) => str));
    }

    List<String>? emailErrors;
    if (json[LoginErrorFields.emailErrors] != null) {
      emailErrors = parseList(json[LoginErrorFields.emailErrors]);
    }
    List<String>? passwordErrors;
    if (json[LoginErrorFields.passwordErrors] != null) {
      passwordErrors = parseList(json[LoginErrorFields.passwordErrors]);
    }
    List<String>? nonFieldErrors;
    if (json[LoginErrorFields.nonFieldErrors] != null) {
      nonFieldErrors = parseList(json[LoginErrorFields.nonFieldErrors]);
    }

    return LoginError(
      emailErrors: emailErrors,
      passwordErrors: passwordErrors,
      nonFieldErrors: nonFieldErrors,
    );
  }

  @override
  List<Object?> get props => [
        emailErrors,
        passwordErrors,
        nonFieldErrors,
      ];
}
