part of 'bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends ProfileEvent {
  final ProfileUpdatePageArgument pageArgument;

  const InitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => [pageArgument];
}

class ChangeProfilePictureEvent extends ProfileEvent {
  const ChangeProfilePictureEvent();

  @override
  List<Object?> get props => [];
}

class UploadCoverMediaEvent extends ProfileEvent {
  final File image;

  const UploadCoverMediaEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class UpdateGender extends ProfileEvent {
  final String? gender;

  UpdateGender(this.gender);

  @override
  List<Object?> get props => [gender];
}

class AddOrRemoveEducation extends ProfileEvent {
  final UiEducation? education;
  final bool? isRemove;

  AddOrRemoveEducation({this.education, this.isRemove});

  @override
  List<Object?> get props => [education, isRemove];
}

class AddOrRemoveWorkExperience extends ProfileEvent {
  final UiWorkExperience? workExperience;
  final bool? isRemove;

  AddOrRemoveWorkExperience({this.workExperience, this.isRemove});

  @override
  List<Object?> get props => [workExperience, isRemove];
}

class AddOrRemoveService extends ProfileEvent {
  final UiService service;
  final bool isRemove;

  AddOrRemoveService(this.service, this.isRemove);

  @override
  List<Object?> get props => [service, isRemove];
}

class SubmitProfile extends ProfileEvent {
  SubmitProfile();

  @override
  List<Object?> get props => [];
}
