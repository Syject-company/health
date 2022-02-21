part of 'personal_data_bloc.dart';

enum ProfileStatus {
  unknown,
  input,
  processing,
  saved,
  error,
  warning,
}

class ProfileState extends Equatable {
  const ProfileState._({
    required this.status,
    this.avatar,
    this.avatarFile,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    this.error,
  });

  factory ProfileState.initial(Profile profile) {
    ImageProvider? provider;
    if (profile.avatar != null && profile.avatar!.isNotEmpty) {
      provider =
          CachedNetworkImageProvider('${AppConstants.apiUrl}${profile.avatar}');
    }

    return ProfileState._(
      status: ProfileStatus.unknown,
      avatar: provider,
      fullName: '${profile.firstName} ${profile.lastName}'.trim(),
      phoneNumber: profile.phoneNumber,
      email: profile.email,
    );
  }

  final ProfileStatus status;
  final ImageProvider? avatar;
  final File? avatarFile;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String? error;

  ProfileState copyWith({
    ProfileStatus? status,
    Nullable<ImageProvider>? avatar,
    Nullable<File>? avatarFile,
    String? fullName,
    String? phoneNumber,
    String? email,
    Nullable<String>? error,
  }) =>
      ProfileState._(
        status: status ?? this.status,
        avatar: avatar != null ? avatar.value : this.avatar,
        avatarFile: avatarFile != null ? avatarFile.value : this.avatarFile,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        avatar,
        avatarFile,
        fullName,
        phoneNumber,
        email,
        error,
      ];
}
