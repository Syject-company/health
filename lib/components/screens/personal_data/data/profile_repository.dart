import 'dart:io';

import 'package:health_plus/locator.dart';
import 'package:health_plus/network/network_response.dart';

import 'model/save_profile_error.dart';
import 'model/save_profile_form.dart';
import 'model/save_profile_response.dart';
import 'profile_service.dart';

mixin ProfileRepository {
  final ProfileService _profileService = locator<ProfileService>();

  Future<NetworkResponse<SaveProfileResponse, SaveProfileError>> saveProfile(
    Map<String, File?>? files,
    SaveProfileForm form,
  ) async {
    return _profileService.saveProfile(files, form);
  }
}
