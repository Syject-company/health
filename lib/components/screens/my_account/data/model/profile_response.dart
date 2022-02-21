import 'package:equatable/equatable.dart';
import 'package:health_plus/model/profile.dart';
import 'package:health_plus/typedefs.dart';

abstract class ProfileResponseFields {
  static const String token = 'token';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String gender = 'gender';
  static const String bio = 'bio';
  static const String phoneNumber = 'phone_number';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String hasSubscription = 'has_subscription';
  static const String canRevealPromotion = 'can_reveal_promotion';
  static const String isVerified = 'is_verified';
}

class ProfileResponse extends Equatable {
  const ProfileResponse({required this.profile});

  final Profile profile;

  static ProfileResponse fromJson(JsonMap json) {
    return ProfileResponse(
      profile: Profile(
        firstName: json[ProfileResponseFields.firstName],
        lastName: json[ProfileResponseFields.lastName],
        gender: json[ProfileResponseFields.gender],
        bio: json[ProfileResponseFields.bio],
        phoneNumber: json[ProfileResponseFields.phoneNumber],
        email: json[ProfileResponseFields.email],
        avatar: json[ProfileResponseFields.avatar],
        hasSubscription: json[ProfileResponseFields.hasSubscription] ?? false,
        canRevealPromotion:
            json[ProfileResponseFields.canRevealPromotion] ?? false,
        isVerified: json[ProfileResponseFields.isVerified] ?? false,
      ),
    );
  }

  @override
  List<Object> get props => [profile];
}
