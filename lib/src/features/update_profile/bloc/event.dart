part of 'bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class InitialEvent extends ProfileEvent {
  final ProfileUpdatePageArgument pageArgument;

  const InitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[pageArgument];
}

class ChangeProfilePictureEvent extends ProfileEvent {
  const ChangeProfilePictureEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class UploadCoverMediaEvent extends ProfileEvent {
  final File image;

  const UploadCoverMediaEvent(this.image);

  @override
  List<Object?> get props => <Object?>[image];
}

class UpdateGender extends ProfileEvent {
  final String? gender;

  const UpdateGender(this.gender);

  @override
  List<Object?> get props => <Object?>[gender];
}

class AddOrRemoveEducation extends ProfileEvent {
  final UiEducation? education;
  final bool? isRemove;

  const AddOrRemoveEducation({this.education, this.isRemove});

  @override
  List<Object?> get props => <Object?>[education, isRemove];
}

class AddOrRemoveWorkExperience extends ProfileEvent {
  final UiWorkExperience? workExperience;
  final bool? isRemove;

  const AddOrRemoveWorkExperience({this.workExperience, this.isRemove});

  @override
  List<Object?> get props => <Object?>[workExperience, isRemove];
}

class AddOrRemoveService extends ProfileEvent {
  final UiService? service;
  final bool? isRemove;

  const AddOrRemoveService({this.service, this.isRemove});

  @override
  List<Object?> get props => <Object?>[service, isRemove];
}

class SubmitProfile extends ProfileEvent {
  const SubmitProfile();

  @override
  List<Object?> get props => <Object?>[];
}
