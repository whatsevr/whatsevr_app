part of 'bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UploadProfilePicture extends ProfileEvent {
  final File image;

  const UploadProfilePicture(this.image);

  @override
  List<Object?> get props => [image];
}

class UploadCoverPicture extends ProfileEvent {
  final File image;

  const UploadCoverPicture(this.image);

  @override
  List<Object?> get props => [image];
}

class SubmitProfile extends ProfileEvent {
  SubmitProfile();

  @override
  List<Object?> get props => [];
}
