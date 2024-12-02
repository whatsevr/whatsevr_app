part of 'bloc.dart';

class UserProfileUpdateState extends Equatable {
  final ProfileDetailsResponse? currentProfileDetailsResponse;

  final DateTime? dob;

  final String? gender;
  final File? profileImage;
  final List<UiCoverMedia>? coverMedia;

  final List<UiService>? services;

  final List<UiEducation>? educations;
  final List<UiWorkExperience>? workExperiences;

  const UserProfileUpdateState({
    this.currentProfileDetailsResponse,
    this.dob,
    this.profileImage,
    this.coverMedia,
    this.services,
    this.educations,
    this.workExperiences,
    this.gender,
  });

  UserProfileUpdateState copyWith({
    ProfileDetailsResponse? currentProfileDetailsResponse,
    DateTime? dob,
    File? profileImage,
    List<UiCoverMedia>? coverMedia,
    List<UiService>? services,
    List<UiEducation>? educations,
    List<UiWorkExperience>? workExperiences,
    String? gender,
  }) {
    return UserProfileUpdateState(
      currentProfileDetailsResponse:
          currentProfileDetailsResponse ?? this.currentProfileDetailsResponse,
      dob: dob ?? this.dob,
      profileImage: profileImage ?? this.profileImage,
      coverMedia: coverMedia ?? this.coverMedia,
      services: services ?? this.services,
      educations: educations ?? this.educations,
      workExperiences: workExperiences ?? this.workExperiences,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentProfileDetailsResponse,
        dob,
        profileImage,
        coverMedia,
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

  const UiEducation({
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
      institute: school ?? institute,
      degreeName: degreeName ?? this.degreeName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isOngoingEducation: isOngoingEducation ?? this.isOngoingEducation,
    );
  }

  @override
  List<Object?> get props => <Object?>[
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

  const UiWorkExperience({
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
  List<Object?> get props => <Object?>[
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

  const UiService({
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
  List<Object?> get props => <Object?>[serviceName, serviceDescription];
}

class UiCoverMedia extends Equatable {
  final String? imageUrl;
  final bool? isVideo;

  final String? videoUrl;

  const UiCoverMedia({
    this.imageUrl,
    this.isVideo,
    this.videoUrl,
  });

  UiCoverMedia copyWith({
    String? imageUrl,
    bool? isVideo,
    String? userUid,
    String? videoUrl,
  }) {
    return UiCoverMedia(
      imageUrl: imageUrl ?? this.imageUrl,
      isVideo: isVideo ?? this.isVideo,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  List<Object?> get props => <Object?>[imageUrl, isVideo, videoUrl];
}
