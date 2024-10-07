part of 'create_offer_bloc.dart';

class CreateOfferState extends Equatable {
  final CreateOfferPageArgument? pageArgument;
  final List<UiFileData> uiFilesData;
  final PlacesNearbyResponse? placesNearbyResponse;
  final String? userCurrentLocationLatLongWkb;
  final String? selectedAddress;
  final String? selectedAddressLatLongWkb;
  final List<String> taggedUsersUid;
  final List<String> taggedCommunitiesUid;
  final String? ctaAction;
  final int? noOfDays;
  const CreateOfferState({
    this.pageArgument,
    this.uiFilesData = const [],
    this.placesNearbyResponse,
    this.userCurrentLocationLatLongWkb,
    this.selectedAddress,
    this.selectedAddressLatLongWkb,
    this.taggedUsersUid = const [],
    this.taggedCommunitiesUid = const [],
    this.ctaAction,
    this.noOfDays = 1,
  });

  @override
  List<Object?> get props => <Object?>[
        pageArgument,
        uiFilesData,
        placesNearbyResponse,
        userCurrentLocationLatLongWkb,
        selectedAddress,
        selectedAddressLatLongWkb,
        taggedUsersUid,
        taggedCommunitiesUid,
        ctaAction,
        noOfDays,
      ];

  CreateOfferState copyWith({
    CreateOfferPageArgument? pageArgument,
    List<UiFileData>? uiFilesData,
    PlacesNearbyResponse? placesNearbyResponse,
    String? userCurrentLocationLatLongWkb,
    String? selectedAddress,
    String? selectedAddressLatLongWkb,
    List<String>? taggedUsersUid,
    List<String>? taggedCommunitiesUid,
    String? ctaAction,
    int? noOfDays,
  }) {
    return CreateOfferState(
      pageArgument: pageArgument ?? this.pageArgument,
      uiFilesData: uiFilesData ?? this.uiFilesData,
      placesNearbyResponse: placesNearbyResponse ?? this.placesNearbyResponse,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedAddressLatLongWkb:
          selectedAddressLatLongWkb ?? this.selectedAddressLatLongWkb,
      taggedUsersUid: taggedUsersUid ?? this.taggedUsersUid,
      taggedCommunitiesUid: taggedCommunitiesUid ?? this.taggedCommunitiesUid,
      ctaAction: ctaAction ?? this.ctaAction,
      noOfDays: noOfDays ?? this.noOfDays,
    );
  }
}

enum UiFileTypes { image, video }

class UiFileData {
  final UiFileTypes? type;
  final File? file;
  final FileMetaData? fileMetaData;
  final File? thumbnailFile;
  final FileMetaData? thumbnailMetaData;

  UiFileData({
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
}
