part of 'bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// class UpdateProfileField extends ProfileEvent {
//   final String field;
//   final String value;
//
//   const UpdateProfileField(this.field, this.value);
//
//   @override
//   List<Object?> get props => [field, value];
// }

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
  final String name;
  final String userName;
  final String email;
  final String mobile;
  final String bio;
  final String address;
  final String dob;
  final String portfolioTitle;
  final String portfolioDescription;
  final String service1;
  final String service2;

  SubmitProfile({
    required this.name,
    required this.userName,
    required this.email,
    required this.mobile,
    required this.bio,
    required this.address,
    required this.dob,
    required this.portfolioTitle,
    required this.portfolioDescription,
    required this.service1,
    required this.service2,
  });

  @override
  List<Object?> get props => [
        name,
        userName,
        email,
        mobile,
        bio,
        address,
        dob,
        portfolioTitle,
        portfolioDescription,
        service1,
        service2,
      ];
}
