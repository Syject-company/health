import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'login_service.dart';
import 'model/login_error.dart';
import 'model/login_form.dart';
import 'model/login_response.dart';

mixin LoginRepository {
  final LoginService _loginService = locator<LoginService>();

  Future<NetworkResponse<LoginResponse, LoginError>> signIn(
      LoginForm form) async {
    return await _loginService.signIn(form);
  }
}
