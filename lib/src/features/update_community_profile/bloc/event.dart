part of 'bloc.dart';

abstract class CommunityProfileUpdateEvent extends Equatable {
  const CommunityProfileUpdateEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class InitialEvent extends CommunityProfileUpdateEvent {
  final CommunityProfileUpdatePageArgument pageArgument;

  const InitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[pageArgument];
}

class ChangeProfilePictureEvent extends CommunityProfileUpdateEvent {
  final File? profileImage;
  const ChangeProfilePictureEvent({this.profileImage});

  @override
  List<Object?> get props => <Object?>[profileImage];
}

class AddOrRemoveCoverMedia extends CommunityProfileUpdateEvent {
  final File? coverImage;
  final File? coverVideo;
  final UiCoverMedia? removableCoverMedia;

  const AddOrRemoveCoverMedia({
    this.coverImage,
    this.coverVideo,
    this.removableCoverMedia,
  });

  @override
  List<Object?> get props =>
      <Object?>[coverImage, coverVideo, removableCoverMedia];
}

class ChangeApproveJoiningRequestEvent extends CommunityProfileUpdateEvent {
  const ChangeApproveJoiningRequestEvent();

  @override
  List<Object?> get props => [];
}

class AddOrRemoveService extends CommunityProfileUpdateEvent {
  final UiService? service;
  final bool? isRemove;

  const AddOrRemoveService({this.service, this.isRemove});

  @override
  List<Object?> get props => <Object?>[service, isRemove];
}

class SubmitProfile extends CommunityProfileUpdateEvent {
  const SubmitProfile();

  @override
  List<Object?> get props => <Object?>[];
}
