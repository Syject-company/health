enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}

extension HttpMethodExtension on HttpMethod {
  String get value {
    switch (this) {
      case HttpMethod.get:
        return 'get';
      case HttpMethod.post:
        return 'post';
      case HttpMethod.put:
        return 'put';
      case HttpMethod.patch:
        return 'patch';
      case HttpMethod.delete:
        return 'delete';
      default:
        return '';
    }
  }
}
