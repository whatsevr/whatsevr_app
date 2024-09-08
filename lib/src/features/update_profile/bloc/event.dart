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
