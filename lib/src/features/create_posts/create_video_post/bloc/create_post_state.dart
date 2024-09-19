part of 'create_post_bloc.dart';

class CreateVideoPostState extends Equatable {
  final CreateVideoPostPageArgument? pageArgument;
  final File? videoFile;
  final File? thumbnailFile;
  final PlacesNearbyResponse? placesNearbyResponse;
  final String? userCurrentLocationLatLongWkb;
  final String? selectedAddress;
  final String? selectedAddressLatLongWkb;

  const CreateVideoPostState({
    this.pageArgument,
    this.videoFile,
    this.thumbnailFile,
    this.placesNearbyResponse,
    this.userCurrentLocationLatLongWkb,
    this.selectedAddress,
    this.selectedAddressLatLongWkb,
  });

  @override
  List<Object?> get props => <Object?>[
        videoFile,
        thumbnailFile,
        pageArgument,
        placesNearbyResponse,
        userCurrentLocationLatLongWkb,
        selectedAddress,
        selectedAddressLatLongWkb,
      ];

  CreateVideoPostState copyWith({
    CreateVideoPostPageArgument? pageArgument,
    File? videoFile,
    File? thumbnailFile,
    PlacesNearbyResponse? placesNearbyResponse,
    String? userCurrentLocationLatLongWkb,
    String? selectedAddress,
    String? selectedAddressLatLongWkb,
  }) {
    return CreateVideoPostState(
      pageArgument: pageArgument ?? this.pageArgument,
      videoFile: videoFile ?? this.videoFile,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      placesNearbyResponse: placesNearbyResponse ?? this.placesNearbyResponse,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedAddressLatLongWkb:
          selectedAddressLatLongWkb ?? this.selectedAddressLatLongWkb,
    );
  }
}
