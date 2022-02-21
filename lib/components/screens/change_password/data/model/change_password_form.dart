import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/serializable.dart';

abstract class ChangePasswordFormFields {
  static const String currentPassword = 'current_password';
  static const String password1 = 'password1';
  static const String password2 = 'password2';
}

class ChangePasswordForm extends Equatable implements JsonSerializable {
  const ChangePasswordForm({
    required this.currentPassword,
    required this.password1,
    required this.password2,
  });

  final String currentPassword;
  final String password1;
  final String password2;

  @override
  JsonMap toJson() {
    return {
      ChangePasswordFormFields.currentPassword: currentPassword,
      ChangePasswordFormFields.password1: password1,
      ChangePasswordFormFields.password2: password2,
    };
  }

  @override
  List<Object> get props => [
        currentPassword,
        password1,
        password2,
      ];
}
