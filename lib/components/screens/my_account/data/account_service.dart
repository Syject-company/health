import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/profile_response.dart';

class AccountService {
  Future<NetworkResponse<ProfileResponse, void>> getProfile() async {
    const url = '${AppConstants.apiBaseUrl}/users/profile/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<ProfileResponse, void>(
      url: url,
      method: HttpMethod.get,
      successParser: ProfileResponse.fromJson,
    );

    return request.send(headers: headers);
  }
}
