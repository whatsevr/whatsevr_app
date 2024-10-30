part of 'create_post_bloc.dart';

sealed class CreateVideoPostEvent extends Equatable {
  const CreateVideoPostEvent();
}

class CreatePostInitialEvent extends CreateVideoPostEvent {
  final CreateVideoPostPageArgument pageArgument;
  const CreatePostInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[];
}

class SubmitPostEvent extends CreateVideoPostEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickVideoEvent extends CreateVideoPostEvent {
  final File? pickVideoFile;
  const PickVideoEvent({required this.pickVideoFile});

  @override
  List<Object?> get props => <Object?>[pickVideoFile];
}

class PickThumbnailEvent extends CreateVideoPostEvent {
  final File? pickedThumbnailFile;
  const PickThumbnailEvent({required this.pickedThumbnailFile});

  @override
  List<Object?> get props => <Object?>[pickedThumbnailFile];
}

class UpdatePostAddressEvent extends CreateVideoPostEvent {
  final String? address;
  final double? addressLatitude;
  final double? addressLongitude;
  const UpdatePostAddressEvent(
      {this.address, this.addressLatitude, this.addressLongitude,});

  @override
  List<Object?> get props =>
      <Object?>[address, addressLatitude, addressLongitude];
}

class UpdateTaggedUsersAndCommunitiesEvent extends CreateVideoPostEvent {
  final bool? clearAll;
  final List<String>? taggedUsersUid;
  final List<String>? taggedCommunitiesUid;
  const UpdateTaggedUsersAndCommunitiesEvent(
      {this.taggedUsersUid, this.taggedCommunitiesUid, this.clearAll,});

  @override
  List<Object?> get props =>
      <Object?>[taggedUsersUid, taggedCommunitiesUid, clearAll];
}
