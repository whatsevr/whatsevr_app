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

class UpdateGender extends CommunityProfileUpdateEvent {
  final String? gender;

  const UpdateGender(this.gender);

  @override
  List<Object?> get props => <Object?>[gender];
}

class AddOrRemoveEducation extends CommunityProfileUpdateEvent {
  final UiEducation? education;
  final bool? isRemove;

  const AddOrRemoveEducation({this.education, this.isRemove});

  @override
  List<Object?> get props => <Object?>[education, isRemove];
}

class AddOrRemoveWorkExperience extends CommunityProfileUpdateEvent {
  final UiWorkExperience? workExperience;
  final bool? isRemove;

  const AddOrRemoveWorkExperience({this.workExperience, this.isRemove});

  @override
  List<Object?> get props => <Object?>[workExperience, isRemove];
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
