part of 'create_flick_bloc.dart';

class CreateMemoryState extends Equatable {
  final CreateMemoryPageArgument? pageArgument;
  final File? videoFile;
  final FileMetaData? videoMetaData;
  final File? thumbnailFile;
  final FileMetaData? thumbnailMetaData;
  final PlacesNearbyResponse? placesNearbyResponse;
  final String? userCurrentLocationLatLongWkb;
  final String? selectedAddress;
  final String? selectedAddressLatLongWkb;
  final List<String> taggedUsersUid;
  final List<String> taggedCommunitiesUid;

  const CreateMemoryState({
    this.pageArgument,
    this.videoFile,
    this.videoMetaData,
    this.thumbnailFile,
    this.thumbnailMetaData,
    this.placesNearbyResponse,
    this.userCurrentLocationLatLongWkb,
    this.selectedAddress,
    this.selectedAddressLatLongWkb,
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
        selectedAddress,
        selectedAddressLatLongWkb,
        taggedUsersUid,
        taggedCommunitiesUid,
      ];

  CreateMemoryState copyWith({
    CreateMemoryPageArgument? pageArgument,
    File? videoFile,
    FileMetaData? videoMetaData,
    File? thumbnailFile,
    FileMetaData? thumbnailMetaData,
    PlacesNearbyResponse? placesNearbyResponse,
    String? userCurrentLocationLatLongWkb,
    String? selectedAddress,
    String? selectedAddressLatLongWkb,
    List<String>? taggedUsersUid,
    List<String>? taggedCommunitiesUid,
  }) {
    return CreateMemoryState(
      pageArgument: pageArgument ?? this.pageArgument,
      videoFile: videoFile ?? this.videoFile,
      videoMetaData: videoMetaData ?? this.videoMetaData,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      thumbnailMetaData: thumbnailMetaData ?? this.thumbnailMetaData,
      placesNearbyResponse: placesNearbyResponse ?? this.placesNearbyResponse,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedAddressLatLongWkb:
          selectedAddressLatLongWkb ?? this.selectedAddressLatLongWkb,
      taggedUsersUid: taggedUsersUid ?? this.taggedUsersUid,
      taggedCommunitiesUid: taggedCommunitiesUid ?? this.taggedCommunitiesUid,
    );
  }
}
