import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/favourites_page_response.dart';

class FavouriteService {
  Future<NetworkResponse<FavouritesPageResponse, void>> getAll({
    String? city,
    String? category,
    List<String>? cities,
    List<String>? categories,
    int? limit,
    int? offset,
  }) async {
    const url = '${AppConstants.apiBaseUrl}/providers/my-favorites/';
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

    final request = NetworkRequest<FavouritesPageResponse, void>(
      url: url,
      method: HttpMethod.get,
      successParser: FavouritesPageResponse.fromJson,
    );

    return request.send(
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<NetworkResponse<void, void>> addToFavourites(
    int id,
  ) async {
    final url = '${AppConstants.apiBaseUrl}/providers/$id/like/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<void, void>(
      url: url,
      method: HttpMethod.post,
    );

    return request.send(headers: headers);
  }

  Future<NetworkResponse<void, void>> removeFromFavourites(
    int id,
  ) async {
    final url = '${AppConstants.apiBaseUrl}/providers/$id/like/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final request = NetworkRequest<void, void>(
      url: url,
      method: HttpMethod.delete,
    );

    return request.send(headers: headers);
  }
}
