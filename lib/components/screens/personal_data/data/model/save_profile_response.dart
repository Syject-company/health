import 'package:equatable/equatable.dart';
import 'package:health_plus/model/profile.dart';
import 'package:health_plus/typedefs.dart';

abstract class SaveProfileResponseFields {
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String gender = 'gender';
  static const String bio = 'bio';
  static const String phoneNumber = 'phone_number';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String isVerified = 'is_verified';
}

class SaveProfileResponse extends Equatable {
  const SaveProfileResponse({required this.profile});

  final Profile profile;

  static SaveProfileResponse fromJson(JsonMap json) {
    return SaveProfileResponse(
      profile: Profile(
        firstName: json[SaveProfileResponseFields.firstName],
        lastName: json[SaveProfileResponseFields.lastName],
        gender: json[SaveProfileResponseFields.gender],
        bio: json[SaveProfileResponseFields.bio],
        phoneNumber: json[SaveProfileResponseFields.phoneNumber],
        email: json[SaveProfileResponseFields.email],
        avatar: json[SaveProfileResponseFields.avatar],
        hasSubscription: false,
        canRevealPromotion: false,
        isVerified: json[SaveProfileResponseFields.isVerified] ?? false,
      ),
    );
  }

  @override
  List<Object> get props => [profile];
}
