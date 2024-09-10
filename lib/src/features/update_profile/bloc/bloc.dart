import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/src/features/update_profile/views/page.dart';

import '../../../../config/api/requests_model/update_profile_picture.dart';
part 'event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController portfolioDescriptionController =
      TextEditingController();
  TextEditingController service1Controller = TextEditingController();

  ProfileBloc() : super(ProfileState()) {
    on<InitialEvent>(_onInitialEvent);
    on<ChangeProfilePictureEvent>(_onChangeProfilePicture);
    on<UploadCoverPicture>(_onUploadCoverPicture);
    on<SubmitProfile>(_onSubmitProfile);
  }
  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      currentProfileDetailsResponse: event.pageArgument.profileDetailsResponse,
      dob: event.pageArgument.profileDetailsResponse?.userInfo?.dob,
    ));
    // Set the initial values of the text controllers
    nameController.text =
        event.pageArgument.profileDetailsResponse?.userInfo?.name ?? '';

    emailController.text =
        event.pageArgument.profileDetailsResponse?.userInfo?.emailId ?? '';

    bioController.text =
        event.pageArgument.profileDetailsResponse?.userInfo?.bio ?? '';
    addressController.text =
        event.pageArgument.profileDetailsResponse?.userInfo?.address ?? '';

    portfolioDescriptionController.text = event.pageArgument
            .profileDetailsResponse?.userInfo?.portfolioDescription ??
        '';
  }

  final ImagePicker _picker = ImagePicker();
  void _onChangeProfilePicture(
      ChangeProfilePictureEvent event, Emitter<ProfileState> emit) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (pickedFile == null) return;
    emit(state.copyWith(profileImage: File(pickedFile.path)));
    String? profilePictureUrl = await FileUploadService.uploadFilesToSST(
      state.profileImage!,
    );
    await UsersApi.updateUserProfilePicture(
      ProfilePictureUpdateRequest(
        userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
        profilePictureUrl: profilePictureUrl,
      ),
    );
  }

  void _onUploadCoverPicture(
      UploadCoverPicture event, Emitter<ProfileState> emit) {
    //
    // emit(state.copyWith(coverImages: Li));
  }

  Future<void> _onSubmitProfile(
      SubmitProfile event, Emitter<ProfileState> emit) async {}
}
