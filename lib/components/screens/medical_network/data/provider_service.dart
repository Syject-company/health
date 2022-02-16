import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/providers_response.dart';

class ProviderService {
  Future<NetworkResponse<ProvidersResponse, void>> getAll({
    String? city,
    String? category,
    List<String>? cities,
    List<String>? categories,
    int? limit,
    int? offset,
  }) async {
    const url = '${AppConstants.apiBaseUrl}/providers/';
    final queryParameters = <String, dynamic>{
      if (city != null) 'city': city,
      if (category != null) 'category': category,
      if (cities != null) 'cities': cities.join(', '),
      if (categories != null) 'categories': categories.join(', '),
      if (limit != null) 'limit': '$limit',
      if (offset != null) 'offset': '$offset',
    };
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<ProvidersResponse, void>(
      url: url,
      method: HttpMethod.get,
      successParser: ProvidersResponse.fromJson,
    );

    return request.send(
      queryParameters: queryParameters,
      headers: headers,
      useToken: false,
    );
  }
}
