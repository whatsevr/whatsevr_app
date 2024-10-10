part of 'create_offer_bloc.dart';

sealed class CreateOfferEvent extends Equatable {
  const CreateOfferEvent();
}

class CreateOfferInitialEvent extends CreateOfferEvent {
  final CreateOfferPageArgument pageArgument;
  const CreateOfferInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[];
}

class SubmitPostEvent extends CreateOfferEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickVideoEvent extends CreateOfferEvent {
  final File? pickedVideoFile;
  const PickVideoEvent({required this.pickedVideoFile});

  @override
  List<Object?> get props => <Object?>[pickedVideoFile];
}

class ChangeVideoThumbnail extends CreateOfferEvent {
  final UiFileData uiFileData;
  final File? pickedThumbnailFile;
  const ChangeVideoThumbnail(
      {required this.pickedThumbnailFile, required this.uiFileData});

  @override
  List<Object?> get props => <Object?>[pickedThumbnailFile, uiFileData];
}

class PickImageEvent extends CreateOfferEvent {
  final File? pickedImageFile;
  const PickImageEvent({required this.pickedImageFile});

  @override
  List<Object?> get props => <Object?>[pickedImageFile];
}

class UpdateTaggedUsersAndCommunitiesEvent extends CreateOfferEvent {
  final bool? clearAll;
  final List<String>? taggedUsersUid;
  final List<String>? taggedCommunitiesUid;
  const UpdateTaggedUsersAndCommunitiesEvent(
      {this.taggedUsersUid, this.taggedCommunitiesUid, this.clearAll});

  @override
  List<Object?> get props =>
      <Object?>[taggedUsersUid, taggedCommunitiesUid, clearAll];
}

class RemoveVideoOrImageEvent extends CreateOfferEvent {
  final UiFileData uiFileData;
  const RemoveVideoOrImageEvent({required this.uiFileData});

  @override
  List<Object?> get props => <Object?>[uiFileData];
}
