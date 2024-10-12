part of 'create_photo_post_bloc.dart';

class CreatePhotoPostState extends Equatable {
  final CreatePhotoPostPageArgument? pageArgument;
  final List<UiFileData> uiFilesData;
  final UiFileData? selectedUiFileData;
  final PlacesNearbyResponse? placesNearbyResponse;
  final String? selectedPostLocation;
  final String? selectedPostLocationLatLongWkb;
  final String? userCurrentLocationLatLongWkb;

  final List<String>? selectedTargetAddresses;

  final List<String> taggedUsersUid;
  final List<String> taggedCommunitiesUid;
  final String? ctaAction;
  final int? noOfDays;
  final String? selectedTargetGender;
  const CreatePhotoPostState({
    this.pageArgument,
    this.uiFilesData = const [],
    this.selectedUiFileData,
    this.placesNearbyResponse,
    this.selectedPostLocation,
    this.selectedPostLocationLatLongWkb,
    this.userCurrentLocationLatLongWkb,
    this.selectedTargetAddresses = const [],
    this.taggedUsersUid = const [],
    this.taggedCommunitiesUid = const [],
    this.ctaAction,
    this.noOfDays = 1,
    this.selectedTargetGender = 'All',
  });

  @override
  List<Object?> get props => <Object?>[
        pageArgument,
        uiFilesData,
        selectedUiFileData,
        placesNearbyResponse,
        selectedPostLocation,
        selectedPostLocationLatLongWkb,
        userCurrentLocationLatLongWkb,
        selectedTargetAddresses,
        selectedTargetAddresses?.length,
        taggedUsersUid,
        taggedCommunitiesUid,
        ctaAction,
        noOfDays,
        selectedTargetGender,
      ];

  CreatePhotoPostState copyWith({
    CreatePhotoPostPageArgument? pageArgument,
    List<UiFileData>? uiFilesData,
    UiFileData? selectedUiFileData,
    PlacesNearbyResponse? placesNearbyResponse,
    String? selectedPostLocation,
    String? selectedPostLocationLatLongWkb,
    String? userCurrentLocationLatLongWkb,
    List<String>? selectedTargetAddresses,
    List<String>? taggedUsersUid,
    List<String>? taggedCommunitiesUid,
    String? ctaAction,
    int? noOfDays,
    String? selectedTargetGender,
  }) {
    return CreatePhotoPostState(
      pageArgument: pageArgument ?? this.pageArgument,
      uiFilesData: uiFilesData ?? this.uiFilesData,
      selectedUiFileData: selectedUiFileData ?? this.selectedUiFileData,
      placesNearbyResponse: placesNearbyResponse ?? this.placesNearbyResponse,
      selectedPostLocation: selectedPostLocation ?? this.selectedPostLocation,
      selectedPostLocationLatLongWkb:
          selectedPostLocationLatLongWkb ?? this.selectedPostLocationLatLongWkb,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
      selectedTargetAddresses:
          selectedTargetAddresses ?? this.selectedTargetAddresses,
      taggedUsersUid: taggedUsersUid ?? this.taggedUsersUid,
      taggedCommunitiesUid: taggedCommunitiesUid ?? this.taggedCommunitiesUid,
      ctaAction: ctaAction ?? this.ctaAction,
      noOfDays: noOfDays ?? this.noOfDays,
      selectedTargetGender: selectedTargetGender ?? this.selectedTargetGender,
    );
  }
}

enum UiFileTypes { image, video }

class UiFileData extends Equatable {
  final UiFileTypes? type;
  final File? file;
  final FileMetaData? fileMetaData;
  final File? thumbnailFile;
  final FileMetaData? thumbnailMetaData;

  const UiFileData({
    this.type,
    this.file,
    this.fileMetaData,
    this.thumbnailFile,
    this.thumbnailMetaData,
  });

  UiFileData copyWith({
    UiFileTypes? type,
    File? file,
    FileMetaData? fileMetaData,
    File? thumbnailFile,
    FileMetaData? thumbnailMetaData,
  }) {
    return UiFileData(
      type: type ?? this.type,
      file: file ?? this.file,
      fileMetaData: fileMetaData ?? this.fileMetaData,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      thumbnailMetaData: thumbnailMetaData ?? this.thumbnailMetaData,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[type, file, fileMetaData, thumbnailFile, thumbnailMetaData];
}
