part of 'create_flick_bloc.dart';

sealed class CreateFlickPostEvent extends Equatable {
  const CreateFlickPostEvent();
}

class CreatePostInitialEvent extends CreateFlickPostEvent {
  final CreateFlickPostPageArgument pageArgument;
  const CreatePostInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[];
}

class SubmitPostEvent extends CreateFlickPostEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickVideoEvent extends CreateFlickPostEvent {
  final File? pickVideoFile;
  const PickVideoEvent({required this.pickVideoFile});

  @override
  List<Object?> get props => <Object?>[pickVideoFile];
}

class PickThumbnailEvent extends CreateFlickPostEvent {
  final File? pickedThumbnailFile;
  const PickThumbnailEvent({required this.pickedThumbnailFile});

  @override
  List<Object?> get props => <Object?>[pickedThumbnailFile];
}

class UpdatePostAddressEvent extends CreateFlickPostEvent {
  final String? address;
  final double? addressLatitude;
  final double? addressLongitude;
  const UpdatePostAddressEvent({
    this.address,
    this.addressLatitude,
    this.addressLongitude,
  });

  @override
  List<Object?> get props =>
      <Object?>[address, addressLatitude, addressLongitude];
}

class UpdateTaggedUsersAndCommunitiesEvent extends CreateFlickPostEvent {
  final bool? clearAll;
  final List<String>? taggedUsersUid;
  final List<String>? taggedCommunitiesUid;
  const UpdateTaggedUsersAndCommunitiesEvent({
    this.taggedUsersUid,
    this.taggedCommunitiesUid,
    this.clearAll,
  });

  @override
  List<Object?> get props =>
      <Object?>[taggedUsersUid, taggedCommunitiesUid, clearAll];
}
