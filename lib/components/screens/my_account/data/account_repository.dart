import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/profile_response.dart';
import 'account_service.dart';

mixin AccountRepository {
  final AccountService _profileService = locator<AccountService>();

  Future<NetworkResponse<ProfileResponse, void>> getProfile() async {
    return await _profileService.getProfile();
  }
}
