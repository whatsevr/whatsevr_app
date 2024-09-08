import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/src/features/update_profile/views/page.dart';
part 'event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController portfolioDescriptionController =
      TextEditingController();
  TextEditingController service1Controller = TextEditingController();
  TextEditingController service2Controller = TextEditingController();

  ProfileBloc() : super(ProfileState()) {
    on<InitialEvent>(_onInitialEvent);
    on<UploadProfilePicture>(_onUploadProfilePicture);
    on<UploadCoverPicture>(_onUploadCoverPicture);
    on<SubmitProfile>(_onSubmitProfile);
  }
  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<ProfileState> emit) {
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

  void _onUploadProfilePicture(
      UploadProfilePicture event, Emitter<ProfileState> emit) {
    // Update profile image in the state
    emit(state.copyWith(profileImage: event.image));
  }

  void _onUploadCoverPicture(
      UploadCoverPicture event, Emitter<ProfileState> emit) {
    // Update cover image in the state
    emit(state.copyWith(coverImage: event.image));
  }

  Future<void> _onSubmitProfile(
      SubmitProfile event, Emitter<ProfileState> emit) async {}
}
