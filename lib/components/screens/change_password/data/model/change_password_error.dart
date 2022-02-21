import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class ChangePasswordErrorFields {
  static const String oldPasswordErrors = 'old_password';
  static const String newPasswordErrors = 'new_password';
  static const String confirmPasswordErrors = 'confirm_password';
  static const String nonFieldErrors = 'non_field_errors';
}

class ChangePasswordError extends Equatable {
  const ChangePasswordError({
    required this.oldPasswordErrors,
    required this.newPasswordErrors,
    required this.confirmPasswordErrors,
    required this.nonFieldErrors,
  });

  final List<String>? oldPasswordErrors;
  final List<String>? newPasswordErrors;
  final List<String>? confirmPasswordErrors;
  final List<String>? nonFieldErrors;

  static ChangePasswordError fromJson(JsonMap json) {
    List<String> parseList<T>(dynamic data) {
      return List<String>.from((data as Iterable).map((str) => str));
    }

    List<String>? oldPasswordErrors;
    if (json[ChangePasswordErrorFields.oldPasswordErrors] != null) {
      final passwordErrorsList =
          (json[ChangePasswordErrorFields.oldPasswordErrors] as Iterable)
              .map((str) => jsonDecode(str.toString().replaceAll('\'', '"')))
              .toList()
              .join();
      oldPasswordErrors =
          passwordErrorsList.replaceAll(RegExp(r'[\[\]]'), '').split(', ');
    } else if (json[ChangePasswordErrorFields.oldPasswordErrors] != null) {
      oldPasswordErrors =
          parseList(json[ChangePasswordErrorFields.oldPasswordErrors]);
    }
    List<String>? newPasswordErrors;
    if (json[ChangePasswordErrorFields.newPasswordErrors] != null) {
      final passwordErrorsList =
          (json[ChangePasswordErrorFields.newPasswordErrors] as Iterable)
              .map((str) => jsonDecode(str.toString().replaceAll('\'', '"')))
              .toList()
              .join();
      oldPasswordErrors =
          passwordErrorsList.replaceAll(RegExp(r'[\[\]]'), '').split(', ');
    } else if (json[ChangePasswordErrorFields.newPasswordErrors] != null) {
      newPasswordErrors =
          parseList(json[ChangePasswordErrorFields.newPasswordErrors]);
    }
    List<String>? confirmPasswordErrors;
    if (json[ChangePasswordErrorFields.newPasswordErrors] != null) {
      final passwordErrorsList =
          (json[ChangePasswordErrorFields.newPasswordErrors] as Iterable)
              .map((str) => jsonDecode(str.toString().replaceAll('\'', '"')))
              .toList()
              .join();
      oldPasswordErrors =
          passwordErrorsList.replaceAll(RegExp(r'[\[\]]'), '').split(', ');
    } else if (json[ChangePasswordErrorFields.newPasswordErrors] != null) {
      newPasswordErrors =
          parseList(json[ChangePasswordErrorFields.newPasswordErrors]);
    }
    List<String>? nonFieldErrors;
    if (json[ChangePasswordErrorFields.nonFieldErrors] != null) {
      nonFieldErrors =
          parseList(json[ChangePasswordErrorFields.nonFieldErrors]);
    }
    return ChangePasswordError(
      nonFieldErrors: nonFieldErrors,
      confirmPasswordErrors: confirmPasswordErrors,
      oldPasswordErrors: oldPasswordErrors,
      newPasswordErrors: newPasswordErrors,
    );
  }

  @override
  List<Object?> get props => [
        oldPasswordErrors,
        newPasswordErrors,
        confirmPasswordErrors,
        nonFieldErrors,
      ];
}
