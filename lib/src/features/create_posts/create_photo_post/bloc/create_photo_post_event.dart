part of 'create_photo_post_bloc.dart';

sealed class CreatePhotoPostEvent extends Equatable {
  const CreatePhotoPostEvent();
}

class CreateOfferInitialEvent extends CreatePhotoPostEvent {
  final CreatePhotoPostPageArgument pageArgument;
  const CreateOfferInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[];
}

class SubmitPostEvent extends CreatePhotoPostEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickImageEvent extends CreatePhotoPostEvent {
  final File? pickedImageFile;
  const PickImageEvent({required this.pickedImageFile});

  @override
  List<Object?> get props => <Object?>[pickedImageFile];
}

class UpdateTaggedUsersAndCommunitiesEvent extends CreatePhotoPostEvent {
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

class RemoveVideoOrImageEvent extends CreatePhotoPostEvent {
  final UiImageData uiFileData;
  const RemoveVideoOrImageEvent({required this.uiFileData});

  @override
  List<Object?> get props => <Object?>[uiFileData];
}

class UpdatePostAddressEvent extends CreatePhotoPostEvent {
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
