import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class SaveProfileErrorFields {
  static const String emailErrors = 'email';
  static const String phoneNumberErrors = 'phone_number';
}

class SaveProfileError extends Equatable {
  const SaveProfileError({
    required this.emailErrors,
    required this.phoneNumberErrors,
  });

  final List<String>? emailErrors;
  final List<String>? phoneNumberErrors;

  static SaveProfileError fromJson(JsonMap json) {
    List<String> parseList<T>(dynamic data) {
      return List<String>.from((data as Iterable).map((str) => str));
    }

    List<String>? emailErrors;
    if (json[SaveProfileErrorFields.emailErrors] != null) {
      emailErrors = parseList(json[SaveProfileErrorFields.emailErrors]);
    }
    List<String>? phoneNumberErrors;
    if (json[SaveProfileErrorFields.phoneNumberErrors] != null) {
      phoneNumberErrors =
          parseList(json[SaveProfileErrorFields.phoneNumberErrors]);
    }

    return SaveProfileError(
      emailErrors: emailErrors,
      phoneNumberErrors: phoneNumberErrors,
    );
  }

  @override
  List<Object?> get props => [
        emailErrors,
        phoneNumberErrors,
      ];
}
