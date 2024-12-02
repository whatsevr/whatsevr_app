part of 'create_offer_bloc.dart';

class CreateOfferState extends Equatable {
  final EnumPostCreatorType? postCreatorType;
  final String? communityUid;
  final List<UiFileData> uiFilesData;
  final UiFileData? selectedUiFileData;

  final String? userCurrentLocationLatLongWkb;

  final List<String>? selectedTargetAddresses;

  final List<String> taggedUsersUid;
  final List<String> taggedCommunitiesUid;
  final String? ctaAction;
  final int? noOfDays;
  final String? selectedTargetGender;
  const CreateOfferState({
    this.postCreatorType,
    this.communityUid,
    this.uiFilesData = const [],
    this.selectedUiFileData,
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
        postCreatorType,
        communityUid,
        uiFilesData,
        selectedUiFileData,
        userCurrentLocationLatLongWkb,
        selectedTargetAddresses,
        selectedTargetAddresses?.length,
        taggedUsersUid,
        taggedCommunitiesUid,
        ctaAction,
        noOfDays,
        selectedTargetGender,
      ];

  CreateOfferState copyWith({
    EnumPostCreatorType? postCreatorType,
    String? communityUid,
    List<UiFileData>? uiFilesData,
    UiFileData? selectedUiFileData,
    String? userCurrentLocationLatLongWkb,
    List<String>? selectedTargetAddresses,
    List<String>? taggedUsersUid,
    List<String>? taggedCommunitiesUid,
    String? ctaAction,
    int? noOfDays,
    String? selectedTargetGender,
  }) {
    return CreateOfferState(
      postCreatorType: postCreatorType ?? this.postCreatorType,
      communityUid: communityUid ?? this.communityUid,
      uiFilesData: uiFilesData ?? this.uiFilesData,
      selectedUiFileData: selectedUiFileData ?? this.selectedUiFileData,
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
