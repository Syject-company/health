import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/promotions_page_response.dart';

class PromotionService {
  Future<NetworkResponse<PromotionsPageResponse, void>> getAll({
    String? category,
    int? limit,
    int? offset,
  }) async {
    const url = '${AppConstants.apiBaseUrl}/promotions/';
    final queryParameters = <String, dynamic>{
      if (category != null) 'category': category,
      if (limit != null) 'limit': '$limit',
      if (offset != null) 'offset': '$offset',
    };
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<PromotionsPageResponse, void>(
      url: url,
      method: HttpMethod.get,
      successParser: PromotionsPageResponse.fromJson,
    );

    return request.send(
      queryParameters: queryParameters,
      headers: headers,
    );
  }
}
