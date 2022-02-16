
import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/save_profile_error.dart';
import 'model/save_profile_form.dart';
import 'support_service.dart';

mixin SupportRepository {
  final SupportService _supportService = locator<SupportService>();

  Future<NetworkResponse<void, SendMessageError>> sendMessage(
    SendMessageForm form,
  ) async {
    return _supportService.sendMessage(form);
  }
}
