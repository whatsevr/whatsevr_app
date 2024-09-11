part of 'bloc.dart';

class ProfileState extends Equatable {
  final ProfileDetailsResponse? currentProfileDetailsResponse;

  final String? name;

  final String? email;

  final String? bio;
  final String? address;
  final DateTime? dob;

  final String? gender;
  final File? profileImage;
  final List<File>? coverImages;
  final List<File>? coverVideos;
  final List<String>? services;
  final String? portfolioTitle;
  final String? portfolioDescription;
  final List<UiEducation>? educations;
  final List<UiWorkExperience>? workExperiences;

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
    this.educations,
    this.workExperiences,
    this.gender,
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
    List<UiEducation>? educations,
    List<UiWorkExperience>? workExperiences,
    String? gender,
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
      educations: educations ?? this.educations,
      workExperiences: workExperiences ?? this.workExperiences,
      gender: gender ?? this.gender,
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
        gender,
      ];
}

class UiEducation extends Equatable {
  final String? degree;
  final String? school;
  final String? fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrentlyStudying;

  UiEducation({
    this.degree,
    this.school,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.isCurrentlyStudying,
  });

  UiEducation copyWith({
    String? degree,
    String? school,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyStudying,
  }) {
    return UiEducation(
      degree: degree ?? this.degree,
      school: school ?? this.school,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyStudying: isCurrentlyStudying ?? this.isCurrentlyStudying,
    );
  }

  @override
  List<Object?> get props => [
        degree,
        school,
        fieldOfStudy,
        startDate,
        endDate,
        isCurrentlyStudying,
      ];
}

class UiWorkExperience extends Equatable {
  final String? title;
  final String? company;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrentlyWorking;

  UiWorkExperience({
    this.title,
    this.company,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrentlyWorking,
  });

  UiWorkExperience copyWith({
    String? title,
    String? company,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
  }) {
    return UiWorkExperience(
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyWorking: isCurrentlyWorking ?? this.isCurrentlyWorking,
    );
  }

  @override
  List<Object?> get props => [
        title,
        company,
        location,
        startDate,
        endDate,
        isCurrentlyWorking,
      ];
}
