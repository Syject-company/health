import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/serializable.dart';

abstract class ResetPasswordFormFields {
  static const String email = 'email';
}

class ResetPasswordForm extends Equatable implements JsonSerializable {
  const ResetPasswordForm({required this.email});

  final String email;

  @override
  JsonMap toJson() {
    return {
      ResetPasswordFormFields.email: email,
    };
  }

  @override
  List<Object> get props => [email];
}
