import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/save_profile_error.dart';
import 'model/save_profile_form.dart';

class SupportService {
  Future<NetworkResponse<void, SendMessageError>> sendMessage(
    SendMessageForm form,
  ) async {
    const url = '${AppConstants.apiBaseUrl}/contact/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<void, SendMessageError>(
      url: url,
      method: HttpMethod.post,
      errorParser: SendMessageError.fromJson,
    );

    return request.send<SendMessageForm>(
      headers: headers,
      body: form,
    );
  }
}
