part of 'bloc.dart';

class ProfileState extends Equatable {
  final ProfileDetailsResponse? currentProfileDetailsResponse;

  final DateTime? dob;

  final String? gender;
  final File? profileImage;
  final List<File>? coverImages;
  final List<File>? coverVideos;
  final List<UiService>? services;

  final List<UiEducation>? educations;
  final List<UiWorkExperience>? workExperiences;

  const ProfileState({
    this.currentProfileDetailsResponse,
    this.dob,
    this.profileImage,
    this.coverImages,
    this.coverVideos,
    this.services,
    this.educations,
    this.workExperiences,
    this.gender,
  });

  ProfileState copyWith({
    ProfileDetailsResponse? currentProfileDetailsResponse,
    DateTime? dob,
    File? profileImage,
    List<File>? coverImages,
    List<File>? coverVideos,
    List<UiService>? services,
    List<UiEducation>? educations,
    List<UiWorkExperience>? workExperiences,
    String? gender,
  }) {
    return ProfileState(
      currentProfileDetailsResponse:
          currentProfileDetailsResponse ?? this.currentProfileDetailsResponse,
      dob: dob ?? this.dob,
      profileImage: profileImage ?? this.profileImage,
      coverImages: coverImages ?? this.coverImages,
      coverVideos: coverVideos ?? this.coverVideos,
      services: services ?? this.services,
      educations: educations ?? this.educations,
      workExperiences: workExperiences ?? this.workExperiences,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
        currentProfileDetailsResponse,
        dob,
        profileImage,
        coverImages,
        coverVideos,
        services,
        gender,
        educations,
        workExperiences,
      ];
}

class UiEducation extends Equatable {
  final String? degreeType;
  final String? institute;
  final String? degreeName;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isOngoingEducation;

  UiEducation({
    this.degreeType,
    this.institute,
    this.degreeName,
    this.startDate,
    this.endDate,
    this.isOngoingEducation,
  });

  UiEducation copyWith({
    String? degreeType,
    String? school,
    String? degreeName,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoingEducation,
  }) {
    return UiEducation(
      degreeType: degreeType ?? this.degreeType,
      institute: school ?? this.institute,
      degreeName: degreeName ?? this.degreeName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isOngoingEducation: isOngoingEducation ?? this.isOngoingEducation,
    );
  }

  @override
  List<Object?> get props => [
        degreeType,
        institute,
        degreeName,
        startDate,
        endDate,
        isOngoingEducation,
      ];
}

class UiWorkExperience extends Equatable {
  final String? companyName;
  final String? designation;
  final String? workingMode;

  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrentlyWorking;

  UiWorkExperience({
    this.companyName,
    this.designation,
    this.workingMode,
    this.startDate,
    this.endDate,
    this.isCurrentlyWorking,
  });

  UiWorkExperience copyWith({
    String? companyName,
    String? designation,
    String? workingMode,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
  }) {
    return UiWorkExperience(
      companyName: companyName ?? this.companyName,
      designation: designation ?? this.designation,
      workingMode: workingMode ?? this.workingMode,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyWorking: isCurrentlyWorking ?? this.isCurrentlyWorking,
    );
  }

  @override
  List<Object?> get props => [
        companyName,
        designation,
        workingMode,
        startDate,
        endDate,
        isCurrentlyWorking,
      ];
}

class UiService extends Equatable {
  final String? serviceName;
  final String? serviceDescription;

  UiService({
    this.serviceName,
    this.serviceDescription,
  });

  UiService copyWith({
    String? serviceName,
    String? serviceDescription,
  }) {
    return UiService(
      serviceName: serviceName ?? this.serviceName,
      serviceDescription: serviceDescription ?? this.serviceDescription,
    );
  }

  @override
  List<Object?> get props => [serviceName, serviceDescription];
}
