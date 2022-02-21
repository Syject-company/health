import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/reset_password_error.dart';
import 'model/reset_password_form.dart';
import 'model/reset_password_response.dart';

class ResetPasswordService {
  Future<NetworkResponse<ResetPasswordResponse, ResetPasswordError>>
      resetPassword(
    ResetPasswordForm form,
  ) async {
    const url = '${AppConstants.apiBaseUrl}/users/forget-password/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<ResetPasswordResponse, ResetPasswordError>(
      url: url,
      method: HttpMethod.post,
      successParser: ResetPasswordResponse.fromJson,
      errorParser: ResetPasswordError.fromJson,
    );

    return request.send<ResetPasswordForm>(
      headers: headers,
      body: form,
    );
  }
}
