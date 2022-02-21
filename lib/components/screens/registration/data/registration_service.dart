import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/registration_error.dart';
import 'model/registration_form.dart';
import 'model/registration_response.dart';

class RegistrationService {
  Future<NetworkResponse<RegistrationResponse, RegistrationError>> signUp(
      RegistrationForm form) async {
    const url = '${AppConstants.apiBaseUrl}/users/register/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<RegistrationResponse, RegistrationError>(
      url: url,
      method: HttpMethod.post,
      successParser: RegistrationResponse.fromJson,
      errorParser: RegistrationError.fromJson,
    );

    return request.send<RegistrationForm>(
      headers: headers,
      body: form,
    );
  }
}
