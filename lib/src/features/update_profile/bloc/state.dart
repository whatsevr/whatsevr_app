part of 'bloc.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? userName;
  final String? email;
  final String? mobile;
  final String? bio;
  final String? address;
  final String? dob;
  final File? profileImage;
  final File? coverImage;
  final String? portfolioTitle;
  final String? portfolioDescription;
  final String? service1;

  const ProfileState({
    this.name,
    this.userName,
    this.email,
    this.mobile,
    this.bio,
    this.address,
    this.dob,
    this.profileImage,
    this.coverImage,
    this.portfolioTitle,
    this.portfolioDescription,
    this.service1,
  });

  ProfileState copyWith({
    String? name,
    String? userName,
    String? email,
    String? mobile,
    String? bio,
    String? address,
    String? dob,
    File? profileImage,
    File? coverImage,
    String? portfolioTitle,
    String? portfolioDescription,
    String? service1,
    String? service2,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return ProfileState(
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      profileImage: profileImage ?? this.profileImage,
      coverImage: coverImage ?? this.coverImage,
      portfolioTitle: portfolioTitle ?? this.portfolioTitle,
      portfolioDescription: portfolioDescription ?? this.portfolioDescription,
      service1: service1 ?? this.service1,
    );
  }

  @override
  List<Object?> get props => [
        name,
        userName,
        email,
        mobile,
        bio,
        address,
        dob,
        profileImage,
        coverImage,
        portfolioTitle,
        portfolioDescription,
        service1,
      ];
}
