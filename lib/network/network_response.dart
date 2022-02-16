import 'dart:convert';

import 'package:http/http.dart';

enum ResponseType {
  success,
  failure,
  error,
  noConnection,
}

extension ResponseTypeExtension on ResponseType {
  String get value {
    switch (this) {
      case ResponseType.success:
        return 'onSuccess';
      case ResponseType.failure:
        return 'onFailure';
      case ResponseType.error:
        return 'onError';
      case ResponseType.noConnection:
        return 'onNoConnection';
      default:
        return '';
    }
  }
}

class NetworkResponse<K, V> {
  NetworkResponse._({
    this.data,
    this.errorData,
    this.errorMessage,
    required this.type,
  });

  factory NetworkResponse.success(Response response, Function? jsonParser) {
    return NetworkResponse._(
      data: response.body.isNotEmpty
          ? jsonParser?.call(jsonDecode(utf8.decode(response.bodyBytes)))
          : null,
      type: ResponseType.success,
    );
  }

  factory NetworkResponse.failure(Response response, Function? jsonParser) {
    return NetworkResponse._(
      errorData: response.body.isNotEmpty
          ? jsonParser?.call(jsonDecode(utf8.decode(response.bodyBytes)))
          : null,
      type: ResponseType.failure,
    );
  }

  factory NetworkResponse.error(String errorMessage) {
    return NetworkResponse._(
      errorMessage: errorMessage,
      type: ResponseType.error,
    );
  }

  factory NetworkResponse.noConnection() {
    return NetworkResponse._(
      errorMessage: 'No Internet connection',
      type: ResponseType.noConnection,
    );
  }

  final K? data;
  final V? errorData;
  final String? errorMessage;
  final ResponseType type;

  final Map<String, Function> _callbacks = {};

  void onSuccess(void Function(K?) onSuccess) {
    _callbacks[ResponseType.success.value] = onSuccess;
  }

  void onFailure(void Function(V?) onFailure) {
    _callbacks[ResponseType.failure.value] = onFailure;
  }

  void onError(void Function(String?) onError) {
    _callbacks[ResponseType.error.value] = onError;
  }

  void onNoConnection(void Function(String?) onNoConnection) {
    _callbacks[ResponseType.noConnection.value] = onNoConnection;
  }

  Future<void> handle() async {
    switch (type) {
      case ResponseType.success:
        return _callbacks[type.value]?.call(data);
      case ResponseType.failure:
        return _callbacks[type.value]?.call(errorData);
      case ResponseType.error:
        return _callbacks[type.value]?.call(errorMessage);
      case ResponseType.noConnection:
        return _callbacks[type.value]?.call(errorMessage);
    }
  }
}
