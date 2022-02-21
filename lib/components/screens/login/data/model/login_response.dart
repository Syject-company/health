import 'package:equatable/equatable.dart';
import 'package:health_plus/model/profile.dart';
import 'package:health_plus/typedefs.dart';

abstract class LoginResponseFields {
  static const String token = 'token';
  static const String hasSubscription = 'has_subscription';
  static const String canRevealPromotion = 'can_reveal_promotion';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String gender = 'gender';
  static const String bio = 'bio';
  static const String phoneNumber = 'phone_number';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String isVerified = 'is_verified';
}

class LoginResponse extends Equatable {
  const LoginResponse({
    required this.token,
    required this.profile,
  });

  final String token;
  final Profile profile;

  static LoginResponse fromJson(JsonMap json) {
    return LoginResponse(
      token: json[LoginResponseFields.token],
      profile: Profile(
        firstName: json[LoginResponseFields.firstName],
        lastName: json[LoginResponseFields.lastName],
        gender: json[LoginResponseFields.gender],
        bio: json[LoginResponseFields.bio],
        phoneNumber: json[LoginResponseFields.phoneNumber],
        email: json[LoginResponseFields.email],
        avatar: json[LoginResponseFields.avatar],
        hasSubscription: json[LoginResponseFields.hasSubscription],
        canRevealPromotion: json[LoginResponseFields.canRevealPromotion],
        isVerified: json[LoginResponseFields.isVerified],
      ),
    );
  }

  @override
  List<Object> get props => [
        token,
        profile,
      ];
}
