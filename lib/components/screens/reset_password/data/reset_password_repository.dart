import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/reset_password_error.dart';
import 'model/reset_password_form.dart';
import 'model/reset_password_response.dart';
import 'reset_password_service.dart';

mixin ResetPasswordRepository {
  final ResetPasswordService _registrationService =
      locator<ResetPasswordService>();

  Future<NetworkResponse<ResetPasswordResponse, ResetPasswordError>>
      resetPassword(
    ResetPasswordForm form,
  ) {
    return _registrationService.resetPassword(form);
  }
}
