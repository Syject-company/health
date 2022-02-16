import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class ResetPasswordErrorFields {
  static const String emailErrors = 'email';
  static const String nonFieldErrors = 'non_field_errors';
}

class ResetPasswordError extends Equatable {
  const ResetPasswordError({
    required this.emailErrors,
    required this.nonFieldErrors,
  });

  final List<String>? emailErrors;
  final List<String>? nonFieldErrors;

  static ResetPasswordError fromJson(JsonMap json) {
    List<String> parseList<T>(dynamic data) {
      return List<String>.from((data as Iterable).map((str) => str));
    }

    List<String>? emailErrors;
    if (json[ResetPasswordErrorFields.emailErrors] != null) {
      emailErrors = parseList(json[ResetPasswordErrorFields.emailErrors]);
    }
    List<String>? nonFieldErrors;
    if (json[ResetPasswordErrorFields.nonFieldErrors] != null) {
      nonFieldErrors = parseList(json[ResetPasswordErrorFields.nonFieldErrors]);
    }

    return ResetPasswordError(
      emailErrors: emailErrors,
      nonFieldErrors: nonFieldErrors,
    );
  }

  @override
  List<Object?> get props => [
        emailErrors,
        nonFieldErrors,
      ];
}
