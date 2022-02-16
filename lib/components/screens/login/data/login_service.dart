import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/login_error.dart';
import 'model/login_form.dart';
import 'model/login_response.dart';

class LoginService {
  Future<NetworkResponse<LoginResponse, LoginError>> signIn(
      LoginForm form) async {
    const url = '${AppConstants.apiBaseUrl}/auth/login/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<LoginResponse, LoginError>(
      url: url,
      method: HttpMethod.post,
      successParser: LoginResponse.fromJson,
      errorParser: LoginError.fromJson,
    );

    return request.send<LoginForm>(
      headers: headers,
      body: form,
    );
  }
}
