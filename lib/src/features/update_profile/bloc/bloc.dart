import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController portfolioTitleController = TextEditingController();
  TextEditingController portfolioDescriptionController =
      TextEditingController();
  TextEditingController service1Controller = TextEditingController();
  TextEditingController service2Controller = TextEditingController();

  ProfileBloc() : super(ProfileState()) {
    on<UploadProfilePicture>(_onUploadProfilePicture);
    on<UploadCoverPicture>(_onUploadCoverPicture);
    on<SubmitProfile>(_onSubmitProfile);
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
      SubmitProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      await Future.delayed(Duration(seconds: 2));

      // Emit success state
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (error) {
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }
}
