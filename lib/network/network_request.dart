import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_plus/app_constants.dart';
import 'package:health_plus/utils/serializable.dart';
import 'package:http/http.dart' as http;

import 'http_method.dart';
import 'network_response.dart';

class NetworkRequest<K, V> {
  NetworkRequest({
    required this.url,
    required this.method,
    this.successParser,
    this.errorParser,
  });

  final String url;
  final HttpMethod method;
  final Function? successParser;
  final Function? errorParser;

  bool shouldRefreshToken = true;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<NetworkResponse<K, V>> send<E extends JsonSerializable>({
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    E? body,
    bool useToken = true,
  }) async {
    if (!(await _isConnectedToNetwork())) {
      return NetworkResponse.noConnection();
    }

    final queryString = Uri(queryParameters: queryParameters).query;
    final request = http.Request(method.value, Uri.parse('$url?$queryString'));
    final accessToken = await _storage.read(key: AppConstants.accessTokenKey);
    log(
      '┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓',
      name: 'API',
    );
    log('┃ Request: method=${method.value.toUpperCase()}', name: 'API');
    log('┃ Request: url=${request.url}', name: 'API');

    if (headers != null && headers.isNotEmpty) {
      request.headers.addAll(headers);
    }

    if (body != null) {
      request.body = jsonEncode(body);
    }

    if (accessToken != null && useToken) {
      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      });
      log('┃ Request: token=$accessToken', name: 'API');
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _handleResponse(response);
  }

  Future<NetworkResponse<K, V>> sendMultipart<E extends MultipartSerializable>({
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Iterable<http.MultipartFile>? files,
    E? fields,
    bool useToken = true,
  }) async {
    if (!(await _isConnectedToNetwork())) {
      return NetworkResponse.noConnection();
    }

    final queryString = Uri(queryParameters: queryParameters).query;
    final request =
        http.MultipartRequest(method.value, Uri.parse('$url?$queryString'));
    final accessToken = await _storage.read(key: AppConstants.accessTokenKey);
    log(
      '┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓',
      name: 'API',
    );
    log('┃ Request: method=${method.value.toUpperCase()}', name: 'API');
    log('┃ Request: url=${request.url}', name: 'API');

    if (headers != null && headers.isNotEmpty) {
      request.headers.addAll(headers);
    }

    if (files != null && files.isNotEmpty) {
      request.files.addAll(files);
    }

    if (fields != null) {
      request.fields.addAll(fields.toMultipart());
    }

    if (accessToken != null && useToken) {
      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      });
      log('┃ Request: token=$accessToken', name: 'API');
    }

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  Future<NetworkResponse<K, V>> _handleResponse(http.Response response) async {
    try {
      log('┃ Response: statusCode=${response.statusCode}', name: 'API');

      if (response.body.isNotEmpty) {
        log('┃ Response: body=${response.body}', name: 'API');
      }

      // unauthorized
      if (response.statusCode == 401) {
        return NetworkResponse.error('Unauthorized, please Sign In again');
      }

      // success
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return NetworkResponse.success(response, successParser);
      }

      // error
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        return NetworkResponse.failure(response, errorParser);
      }
      return NetworkResponse.error('Internal Server Error');
    } finally {
      log(
        '┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛',
        name: 'API',
      );
    }
  }

  Future<bool> _isConnectedToNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
