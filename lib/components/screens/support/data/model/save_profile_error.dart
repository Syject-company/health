import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class SaveProfileErrorFields {
  static const String fullNameErrors = 'name';
  static const String phoneNumberErrors = 'phone_number';
  static const String typeErrors = 'type';
  static const String subjectErrors = 'subject';
  static const String descriptionErrors = 'description';
}

class SendMessageError extends Equatable {
  const SendMessageError({
    this.fullNameErrors,
    this.phoneNumberErrors,
    this.typeErrors,
    this.subjectErrors,
    this.descriptionErrors,
  });

  final List<String>? fullNameErrors;
  final List<String>? phoneNumberErrors;
  final List<String>? typeErrors;
  final List<String>? subjectErrors;
  final List<String>? descriptionErrors;

  static SendMessageError fromJson(JsonMap json) {
    List<String> parseList<T>(dynamic data) {
      return List<String>.from((data as Iterable).map((str) => str));
    }

    List<String>? fullNameErrors;
    if (json[SaveProfileErrorFields.fullNameErrors] != null) {
      fullNameErrors = parseList(json[SaveProfileErrorFields.fullNameErrors]);
    }
    List<String>? phoneNumberErrors;
    if (json[SaveProfileErrorFields.phoneNumberErrors] != null) {
      phoneNumberErrors =
          parseList(json[SaveProfileErrorFields.phoneNumberErrors]);
    }
    List<String>? typeErrors;
    if (json[SaveProfileErrorFields.typeErrors] != null) {
      typeErrors = parseList(json[SaveProfileErrorFields.typeErrors]);
    }
    List<String>? subjectErrors;
    if (json[SaveProfileErrorFields.subjectErrors] != null) {
      subjectErrors = parseList(json[SaveProfileErrorFields.subjectErrors]);
    }
    List<String>? descriptionErrors;
    if (json[SaveProfileErrorFields.descriptionErrors] != null) {
      descriptionErrors =
          parseList(json[SaveProfileErrorFields.descriptionErrors]);
    }

    return SendMessageError(
      fullNameErrors: fullNameErrors,
      phoneNumberErrors: phoneNumberErrors,
      typeErrors: typeErrors,
      subjectErrors: subjectErrors,
      descriptionErrors: descriptionErrors,
    );
  }

  @override
  List<Object?> get props => [
        fullNameErrors,
        phoneNumberErrors,
        typeErrors,
        subjectErrors,
        descriptionErrors,
      ];
}
