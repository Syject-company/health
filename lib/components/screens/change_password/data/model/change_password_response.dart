import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class ChangePasswordResponseFields {
  static const String currentPassword = 'current_password';
  static const String password1 = 'password1';
  static const String password2 = 'confirmPassword';
}

class ChangePasswordResponse extends Equatable {
  const ChangePasswordResponse({
    required this.currentPassword,
    required this.password1,
    required this.password2,
  });

  final String currentPassword;
  final String password1;
  final String password2;

  static ChangePasswordResponse fromJson(JsonMap json) {
    return ChangePasswordResponse(
      currentPassword: json[ChangePasswordResponseFields.currentPassword],
      password1: json[ChangePasswordResponseFields.password1],
      password2: json[ChangePasswordResponseFields.password2],
    );
  }

  @override
  List<Object> get props => [
        currentPassword,
        password1,
        password2,
      ];
}
