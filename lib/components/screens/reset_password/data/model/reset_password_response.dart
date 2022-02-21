import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';

abstract class ResetPasswordResponseFields {
  static const String email = 'email';
}

class ResetPasswordResponse extends Equatable {
  const ResetPasswordResponse({required this.email});

  final String email;

  static ResetPasswordResponse fromJson(JsonMap json) {
    return ResetPasswordResponse(
      email: json[ResetPasswordResponseFields.email],
    );
  }

  @override
  List<Object> get props => [email];
}
