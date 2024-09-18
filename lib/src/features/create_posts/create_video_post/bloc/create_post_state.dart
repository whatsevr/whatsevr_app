part of 'create_post_bloc.dart';

class CreateVideoPostState extends Equatable {
  final CreateVideoPostPageArgument? pageArgument;
  final File? videoFile;
  final File? thumbnailFile;
  final PlacesNearbyResponse? placesNearbyResponse;
  const CreateVideoPostState({
    this.pageArgument,
    this.videoFile,
    this.thumbnailFile,
    this.placesNearbyResponse,
  });

  @override
  List<Object?> get props => <Object?>[
        videoFile,
        thumbnailFile,
        pageArgument,
        placesNearbyResponse,
      ];

  CreateVideoPostState copyWith({
    CreateVideoPostPageArgument? pageArgument,
    File? videoFile,
    File? thumbnailFile,
    PlacesNearbyResponse? placesNearbyResponse,
  }) {
    return CreateVideoPostState(
      pageArgument: pageArgument ?? this.pageArgument,
      videoFile: videoFile ?? this.videoFile,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      placesNearbyResponse: placesNearbyResponse ?? this.placesNearbyResponse,
    );
  }
}
