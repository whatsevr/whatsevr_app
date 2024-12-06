part of 'bloc.dart';

class CommunityProfileUpdateState extends Equatable {
  final CommunityProfileDataResponse? currentProfileDetailsResponse;

  final File? profileImage;
  final List<UiCoverMedia>? coverMedia;

  final List<UiService>? services;
  final bool? requireJoiningApproval;

  const CommunityProfileUpdateState({
    this.currentProfileDetailsResponse,
    this.profileImage,
    this.coverMedia,
    this.services,
    this.requireJoiningApproval,
  });

  CommunityProfileUpdateState copyWith({
    CommunityProfileDataResponse? currentProfileDetailsResponse,
    File? profileImage,
    List<UiCoverMedia>? coverMedia,
    List<UiService>? services,
     bool? requireJoiningApproval,
  }) {
    return CommunityProfileUpdateState(
      currentProfileDetailsResponse:
          currentProfileDetailsResponse ?? this.currentProfileDetailsResponse,
      profileImage: profileImage ?? this.profileImage,
      coverMedia: coverMedia ?? this.coverMedia,
      services: services ?? this.services,
      requireJoiningApproval:  requireJoiningApproval ?? this.requireJoiningApproval,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentProfileDetailsResponse,
        profileImage,
        coverMedia,
        services,
        requireJoiningApproval,
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
