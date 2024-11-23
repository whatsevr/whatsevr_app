part of 'create_memory_bloc.dart';

sealed class CreateMemoryEvent extends Equatable {
  const CreateMemoryEvent();
}

class CreateMemoryInitialEvent extends CreateMemoryEvent {
  final CreateMemoryPageArgument pageArgument;
  const CreateMemoryInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[];
}

class SubmitPostEvent extends CreateMemoryEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickVideoEvent extends CreateMemoryEvent {
  final File? pickVideoFile;
  const PickVideoEvent({required this.pickVideoFile});

  @override
  List<Object?> get props => <Object?>[pickVideoFile];
}

class PickThumbnailEvent extends CreateMemoryEvent {
  final File? pickedThumbnailFile;
  const PickThumbnailEvent({required this.pickedThumbnailFile});

  @override
  List<Object?> get props => <Object?>[pickedThumbnailFile];
}

class PickImageEvent extends CreateMemoryEvent {
  final File? pickedImageFile;
  const PickImageEvent({required this.pickedImageFile});

  @override
  List<Object?> get props => <Object?>[pickedImageFile];
}

class UpdatePostAddressEvent extends CreateMemoryEvent {
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

class UpdateTaggedUsersAndCommunitiesEvent extends CreateMemoryEvent {
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

class RemoveVideoOrImageEvent extends CreateMemoryEvent {
  const RemoveVideoOrImageEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class CreateVideoMemoryEvent extends CreateMemoryEvent {
  final List<String> hashtags;
  const CreateVideoMemoryEvent({required this.hashtags});

  @override
  List<Object?> get props => <Object?>[hashtags];
}

class CreateImageMemoryEvent extends CreateMemoryEvent {
  final List<String> hashtags;
  const CreateImageMemoryEvent({required this.hashtags});

  @override
  List<Object?> get props => <Object?>[hashtags];
}

class UpdateCtaActionEvent extends CreateMemoryEvent {
  final String? ctaAction;
  const UpdateCtaActionEvent({this.ctaAction});

  @override
  List<Object?> get props => <Object?>[ctaAction];
}

class UpdateNoOfDaysEvent extends CreateMemoryEvent {
  final int? noOfDays;
  const UpdateNoOfDaysEvent({this.noOfDays});

  @override
  List<Object?> get props => <Object?>[noOfDays];
}
