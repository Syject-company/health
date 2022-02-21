import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class RegistrationErrorFields {
  static const String emailErrors = 'email';
  static const String passwordErrors = 'password';
  static const String password1Errors = 'password1';
  static const String nonFieldErrors = 'non_field_errors';
}

class RegistrationError extends Equatable {
  const RegistrationError({
    required this.emailErrors,
    required this.passwordErrors,
    required this.nonFieldErrors,
  });

  final List<String>? emailErrors;
  final List<String>? passwordErrors;
  final List<String>? nonFieldErrors;

  static RegistrationError fromJson(JsonMap json) {
    List<String> parseList<T>(dynamic data) {
      return List<String>.from((data as Iterable).map((str) => str));
    }

    List<String>? emailErrors;
    if (json[RegistrationErrorFields.emailErrors] != null) {
      emailErrors = parseList(json[RegistrationErrorFields.emailErrors]);
    }
    List<String>? passwordErrors;
    if (json[RegistrationErrorFields.passwordErrors] != null) {
      final passwordErrorsList =
          (json[RegistrationErrorFields.passwordErrors] as Iterable)
              .map((str) => jsonDecode(str.toString().replaceAll('\'', '"')))
              .toList()
              .join();
      passwordErrors =
          passwordErrorsList.replaceAll(RegExp(r'[\[\]]'), '').split(', ');
    } else if (json[RegistrationErrorFields.password1Errors] != null) {
      passwordErrors = parseList(json[RegistrationErrorFields.password1Errors]);
    }
    List<String>? nonFieldErrors;
    if (json[RegistrationErrorFields.nonFieldErrors] != null) {
      nonFieldErrors = parseList(json[RegistrationErrorFields.nonFieldErrors]);
    }

    return RegistrationError(
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
