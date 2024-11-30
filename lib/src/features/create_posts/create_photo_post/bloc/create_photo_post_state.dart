part of 'create_photo_post_bloc.dart';

class CreatePhotoPostState extends Equatable {
  final EnumPostCreatorType? postCreatorType;
  final String? communityUid;
  final List<UiImageData> uiImageData;
  final UiImageData? selectedUiFileData;
  final PlacesNearbyResponse? placesNearbyResponse;
  final String? selectedPostLocation;
  final String? selectedPostLocationLatLongWkb;
  final String? userCurrentLocationLatLongWkb;

  final List<String> taggedUsersUid;
  final List<String> taggedCommunitiesUid;

  const CreatePhotoPostState({
    this.postCreatorType,
    this.communityUid,
    this.uiImageData = const [],
    this.selectedUiFileData,
    this.placesNearbyResponse,
    this.selectedPostLocation,
    this.selectedPostLocationLatLongWkb,
    this.userCurrentLocationLatLongWkb,
    this.taggedUsersUid = const [],
    this.taggedCommunitiesUid = const [],
  });

  @override
  List<Object?> get props => <Object?>[
        postCreatorType,
        communityUid,
        uiImageData,
        selectedUiFileData,
        placesNearbyResponse,
        selectedPostLocation,
        selectedPostLocationLatLongWkb,
        userCurrentLocationLatLongWkb,
        taggedUsersUid,
        taggedCommunitiesUid,
      ];

  CreatePhotoPostState copyWith({
    EnumPostCreatorType? postCreatorType,
    String? communityUid,
    List<UiImageData>? uiFilesData,
    UiImageData? selectedUiFileData,
    PlacesNearbyResponse? placesNearbyResponse,
    String? selectedPostLocation,
    String? selectedPostLocationLatLongWkb,
    String? userCurrentLocationLatLongWkb,
    List<String>? taggedUsersUid,
    List<String>? taggedCommunitiesUid,
  }) {
    return CreatePhotoPostState(
      postCreatorType: postCreatorType ?? this.postCreatorType,
      communityUid: communityUid ?? this.communityUid,
      uiImageData: uiFilesData ?? uiImageData,
      selectedUiFileData: selectedUiFileData ?? this.selectedUiFileData,
      placesNearbyResponse: placesNearbyResponse ?? this.placesNearbyResponse,
      selectedPostLocation: selectedPostLocation ?? this.selectedPostLocation,
      selectedPostLocationLatLongWkb:
          selectedPostLocationLatLongWkb ?? this.selectedPostLocationLatLongWkb,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
      taggedUsersUid: taggedUsersUid ?? this.taggedUsersUid,
      taggedCommunitiesUid: taggedCommunitiesUid ?? this.taggedCommunitiesUid,
    );
  }
}

class UiImageData extends Equatable {
  final File? file;
  final FileMetaData? fileMetaData;

  const UiImageData({
    this.file,
    this.fileMetaData,
  });

  UiImageData copyWith({
    File? file,
    FileMetaData? fileMetaData,
  }) {
    return UiImageData(
      file: file ?? this.file,
      fileMetaData: fileMetaData ?? this.fileMetaData,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        file,
        fileMetaData,
      ];
}
