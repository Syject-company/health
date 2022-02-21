
import 'package:equatable/equatable.dart';
import 'package:health_plus/typedefs.dart';
import 'package:health_plus/utils/serializable.dart';

abstract class SaveProfileFormFields {
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String gender = 'gender';
  static const String bio = 'bio';
  static const String phoneNumber = 'phone_number';
  static const String email = 'email';
}

class SaveProfileForm extends Equatable implements MultipartSerializable {
  const SaveProfileForm({
    this.firstName,
    this.lastName,
    this.gender,
    this.bio,
    this.phoneNumber,
    this.email,
  });

  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? bio;
  final String? phoneNumber;
  final String? email;

  @override
  MultipartMap toMultipart() {
    Map<String, String?> map = {
      SaveProfileFormFields.firstName: firstName,
      SaveProfileFormFields.lastName: lastName,
      SaveProfileFormFields.gender: gender,
      SaveProfileFormFields.bio: bio,
      SaveProfileFormFields.phoneNumber: phoneNumber,
      SaveProfileFormFields.email: email,
    }..removeWhere((key, value) => value == null);
    return map.map((key, value) => MapEntry(key, value!)).cast();
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        gender,
        bio,
        phoneNumber,
        email,
      ];
}
