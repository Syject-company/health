part of 'account_bloc.dart';

enum UserRole {
  guest,
  user,
}

class AccountState extends Equatable {
  const AccountState._({
    required this.profile,
    required this.role,
  });

  factory AccountState.guest() {
    return const AccountState._(
      profile: Profile(
        firstName: 'Guest',
        lastName: '',
        gender: null,
        bio: null,
        phoneNumber: '',
        email: '',
        avatar: null,
        hasSubscription: false,
        canRevealPromotion: false,
        isVerified: false,
      ),
      role: UserRole.guest,
    );
  }

  factory AccountState.user(Profile profile) {
    return AccountState._(
      profile: profile,
      role: UserRole.user,
    );
  }

  final Profile profile;
  final UserRole role;

  @override
  List<Object> get props => [
        profile,
        role,
      ];
}
