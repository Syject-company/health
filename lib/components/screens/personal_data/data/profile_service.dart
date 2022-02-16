import 'dart:io';

import 'package:health_plus/app_constants.dart';
import 'package:health_plus/network/http_method.dart';
import 'package:health_plus/network/network_request.dart';
import 'package:health_plus/network/network_response.dart';
import 'package:http/http.dart' as http;

import 'model/save_profile_error.dart';
import 'model/save_profile_form.dart';
import 'model/save_profile_response.dart';

class ProfileService {
  Future<NetworkResponse<SaveProfileResponse, SaveProfileError>> saveProfile(
    Map<String, File?>? files,
    SaveProfileForm form,
  ) async {
    const url = '${AppConstants.apiBaseUrl}/users/profile/';
    final headers = <String, String>{
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader:
          'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW',
    };

    final request = NetworkRequest<SaveProfileResponse, SaveProfileError>(
      url: url,
      method: HttpMethod.patch,
      successParser: SaveProfileResponse.fromJson,
      errorParser: SaveProfileError.fromJson,
    );

    final multipartFiles = <String, http.MultipartFile>{};
    if (files != null && files.isNotEmpty) {
      files.forEach((field, file) {
        if (file != null) {
          final filename = file.path.substring(file.path.lastIndexOf('/') + 1);

          multipartFiles[field] = http.MultipartFile(
            field,
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: filename,
          );
        }
      });
    }

    return request.sendMultipart<SaveProfileForm>(
      headers: headers,
      files: multipartFiles.values,
      fields: form,
    );
  }
}
