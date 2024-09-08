part of 'bloc.dart';

class ProfileState extends Equatable {
  final ProfileDetailsResponse? currentProfileDetailsResponse;
  final String? name;

  final String? email;

  final String? bio;
  final String? address;
  final String? dob;
  final File? profileImage;
  final File? coverImage;
  final List<String>? services;
  final String? portfolioTitle;
  final String? portfolioDescription;
  const ProfileState({
    this.currentProfileDetailsResponse,
    this.name,
    this.email,
    this.bio,
    this.address,
    this.dob,
    this.profileImage,
    this.coverImage,
    this.portfolioTitle,
    this.portfolioDescription,
    this.services,
  });

  ProfileState copyWith({
    ProfileDetailsResponse? currentProfileDetailsResponse,
    String? name,
    String? email,
    String? bio,
    String? address,
    String? dob,
    File? profileImage,
    File? coverImage,
    String? portfolioTitle,
    String? portfolioDescription,
    List<String>? services,
  }) {
    return ProfileState(
      currentProfileDetailsResponse:
          currentProfileDetailsResponse ?? this.currentProfileDetailsResponse,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      profileImage: profileImage ?? this.profileImage,
      coverImage: coverImage ?? this.coverImage,
      portfolioTitle: portfolioTitle ?? this.portfolioTitle,
      portfolioDescription: portfolioDescription ?? this.portfolioDescription,
      services: services ?? this.services,
    );
  }

  @override
  List<Object?> get props => [
        currentProfileDetailsResponse,
        name,
        email,
        bio,
        address,
        dob,
        profileImage,
        coverImage,
        portfolioTitle,
        portfolioDescription,
        services,
      ];
}
