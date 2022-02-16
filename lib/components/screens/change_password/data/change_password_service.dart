import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/change_password_error.dart';
import 'model/change_password_form.dart';

class ChangePasswordService {
  Future<NetworkResponse<void, ChangePasswordError>> changePassword(
    ChangePasswordForm form,
  ) async {
    const url = '${AppConstants.apiBaseUrl}/users/change-password/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<void, ChangePasswordError>(
      url: url,
      method: HttpMethod.put,
      errorParser: ChangePasswordError.fromJson,
    );

    return request.send<ChangePasswordForm>(
      headers: headers,
      body: form,
    );
  }
}
