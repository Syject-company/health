import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/registration_error.dart';
import 'model/registration_form.dart';
import 'model/registration_response.dart';
import 'registration_service.dart';

mixin RegistrationRepository {
  final RegistrationService _registrationService =
      locator<RegistrationService>();

  Future<NetworkResponse<RegistrationResponse, RegistrationError>> signUp(
      RegistrationForm form) async {
    return await _registrationService.signUp(form);
  }
}
