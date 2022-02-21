import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/categories_response.dart';

class CategoryService {
  Future<NetworkResponse<CategoriesResponse, void>> getAll({
    int? limit,
    int? offset,
  }) async {
    const url = '${AppConstants.apiBaseUrl}/categories/';
    final queryParameters = <String, dynamic>{
      if (limit != null) 'limit': '$limit',
      if (offset != null) 'offset': '$offset',
    };
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<CategoriesResponse, void>(
      url: url,
      method: HttpMethod.get,
      successParser: CategoriesResponse.fromJson,
    );

    return request.send(
      queryParameters: queryParameters,
      headers: headers,
      useToken: false,
    );
  }
}
