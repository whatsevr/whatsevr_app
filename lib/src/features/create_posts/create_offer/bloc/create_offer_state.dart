part of 'create_offer_bloc.dart';

class CreateOfferState extends Equatable {
  final CreateOfferPageArgument? pageArgument;
  final bool? isVideoMemory;
  final bool? isImageMemory;
  final File? videoFile;

  final FileMetaData? videoMetaData;
  final File? thumbnailFile;
  final FileMetaData? thumbnailMetaData;
  final File? imageFile;
  final FileMetaData? imageMetaData;
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
    this.isVideoMemory,
    this.isImageMemory,
    this.videoFile,
    this.videoMetaData,
    this.thumbnailFile,
    this.thumbnailMetaData,
    this.imageFile,
    this.imageMetaData,
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
        videoFile,
        videoMetaData,
        thumbnailFile,
        thumbnailMetaData,
        imageFile,
        imageMetaData,
        pageArgument,
        isVideoMemory,
        isImageMemory,
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
    bool? isVideoMemory,
    bool? isImageMemory,
    File? videoFile,
    FileMetaData? videoMetaData,
    File? thumbnailFile,
    FileMetaData? thumbnailMetaData,
    File? imageFile,
    FileMetaData? imageMetaData,
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
      isVideoMemory: isVideoMemory ?? this.isVideoMemory,
      isImageMemory: isImageMemory ?? this.isImageMemory,
      videoFile: videoFile ?? this.videoFile,
      videoMetaData: videoMetaData ?? this.videoMetaData,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      thumbnailMetaData: thumbnailMetaData ?? this.thumbnailMetaData,
      imageFile: imageFile ?? this.imageFile,
      imageMetaData: imageMetaData ?? this.imageMetaData,
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
