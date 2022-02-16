import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.firstName,
    required this.lastName,
    this.gender,
    this.bio,
    required this.phoneNumber,
    required this.email,
    this.avatar,
    required this.hasSubscription,
    required this.canRevealPromotion,
    required this.isVerified,
  });

  final String firstName;
  final String lastName;
  final String? gender;
  final String? bio;
  final String phoneNumber;
  final String email;
  final String? avatar;
  final bool hasSubscription;
  final bool canRevealPromotion;
  final bool isVerified;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        gender,
        bio,
        phoneNumber,
        email,
        avatar,
        hasSubscription,
        canRevealPromotion,
        isVerified,
      ];
}
