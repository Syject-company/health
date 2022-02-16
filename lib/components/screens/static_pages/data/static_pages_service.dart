import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/static_page_response.dart';

class StaticPagesService {
  Future<NetworkResponse<StaticPageResponse, void>> getPageByKey(
    String key,
  ) {
    final url = '${AppConstants.apiBaseUrl}/static-pages/$key/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<StaticPageResponse, void>(
      url: url,
      method: HttpMethod.get,
      successParser: StaticPageResponse.fromJson,
    );

    return request.send(
      headers: headers,
      useToken: false,
    );
  }
}
