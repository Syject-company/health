import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/plans_page_responce.dart';

class PlanService {
  Future<NetworkResponse<PlansPageResponse, void>> getAll({
    int? limit,
    int? offset,
  }) {
    const url = '${AppConstants.apiBaseUrl}/plans/';
    final queryParameters = <String, dynamic>{
      if (limit != null) 'limit': '$limit',
      if (offset != null) 'offset': '$offset',
    };
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<PlansPageResponse, void>(
      url: url,
      method: HttpMethod.get,
      successParser: PlansPageResponse.fromJson,
    );

    return request.send(
      queryParameters: queryParameters,
      headers: headers,
    );
  }
}
