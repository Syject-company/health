import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/static_page_response.dart';
import 'static_pages_service.dart';

mixin StaticPagesRepository {
  final StaticPagesService _staticPagesService = locator<StaticPagesService>();

  Future<NetworkResponse<StaticPageResponse, void>> getPageByKey(
    String key,
  ) async {
    return await _staticPagesService.getPageByKey(key);
  }
}
