part of 'bloc.dart';

class ProfileState extends Equatable {
  final ProfileDetailsResponse? currentProfileDetailsResponse;

  final String? name;

  final String? email;

  final String? bio;
  final String? address;
  final DateTime? dob;
  final File? profileImage;
  final List<File>? coverImages;
  final List<File>? coverVideos;
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
    this.coverImages,
    this.coverVideos,
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
    DateTime? dob,
    File? profileImage,
    List<File>? coverImages,
    List<File>? coverVideos,
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
      coverImages: coverImages ?? this.coverImages,
      coverVideos: coverVideos ?? this.coverVideos,
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
        coverImages,
        coverVideos,
        portfolioTitle,
        portfolioDescription,
        services,
      ];
}
