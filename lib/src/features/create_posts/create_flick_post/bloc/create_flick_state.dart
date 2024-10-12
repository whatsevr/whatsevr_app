part of 'create_flick_bloc.dart';

class CreateFlickPostState extends Equatable {
  final CreateFlickPostPageArgument? pageArgument;
  final File? videoFile;
  final FileMetaData? videoMetaData;
  final File? thumbnailFile;
  final FileMetaData? thumbnailMetaData;
  final PlacesNearbyResponse? placesNearbyResponse;
  final String? selectedPostLocation;
  final String? selectedPostLocationLatLongWkb;
  final String? userCurrentLocationLatLongWkb;

  final List<String> taggedUsersUid;
  final List<String> taggedCommunitiesUid;

  const CreateFlickPostState({
    this.pageArgument,
    this.videoFile,
    this.videoMetaData,
    this.thumbnailFile,
    this.thumbnailMetaData,
    this.placesNearbyResponse,
    this.userCurrentLocationLatLongWkb,
    this.selectedPostLocation,
    this.selectedPostLocationLatLongWkb,
    this.taggedUsersUid = const [],
    this.taggedCommunitiesUid = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        videoFile,
        videoMetaData,
        thumbnailFile,
        thumbnailMetaData,
        pageArgument,
        placesNearbyResponse,
        userCurrentLocationLatLongWkb,
        selectedPostLocation,
        selectedPostLocationLatLongWkb,
        taggedUsersUid,
        taggedCommunitiesUid,
      ];

  CreateFlickPostState copyWith({
    CreateFlickPostPageArgument? pageArgument,
    File? videoFile,
    FileMetaData? videoMetaData,
    File? thumbnailFile,
    FileMetaData? thumbnailMetaData,
    PlacesNearbyResponse? placesNearbyResponse,
    String? userCurrentLocationLatLongWkb,
    String? selectedPostLocation,
    String? selectedPostLocationLatLongWkb,
    List<String>? taggedUsersUid,
    List<String>? taggedCommunitiesUid,
  }) {
    return CreateFlickPostState(
      pageArgument: pageArgument ?? this.pageArgument,
      videoFile: videoFile ?? this.videoFile,
      videoMetaData: videoMetaData ?? this.videoMetaData,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      thumbnailMetaData: thumbnailMetaData ?? this.thumbnailMetaData,
      placesNearbyResponse: placesNearbyResponse ?? this.placesNearbyResponse,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
      selectedPostLocation: selectedPostLocation ?? this.selectedPostLocation,
      selectedPostLocationLatLongWkb:
          selectedPostLocationLatLongWkb ?? this.selectedPostLocationLatLongWkb,
      taggedUsersUid: taggedUsersUid ?? this.taggedUsersUid,
      taggedCommunitiesUid: taggedCommunitiesUid ?? this.taggedCommunitiesUid,
    );
  }
}
