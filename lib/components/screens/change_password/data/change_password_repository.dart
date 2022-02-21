import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'change_password_service.dart';
import 'model/change_password_error.dart';
import 'model/change_password_form.dart';

mixin ChangePasswordRepository {
  final ChangePasswordService _changePasswordService =
      locator<ChangePasswordService>();

  Future<NetworkResponse<void, ChangePasswordError>> changePassword(
    ChangePasswordForm form,
  ) async {
    return _changePasswordService.changePassword(form);
  }
}
