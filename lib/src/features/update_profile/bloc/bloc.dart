import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    // Register event handlers
    // on<UpdateProfileField>(_onUpdateProfileField);
    on<UploadProfilePicture>(_onUploadProfilePicture);
    on<UploadCoverPicture>(_onUploadCoverPicture);
    on<SubmitProfile>(_onSubmitProfile);
  }

  // void _onUpdateProfileField(
  //     UpdateProfileField event, Emitter<ProfileState> emit) {
  //   // Update specific field based on the event
  //   emit(state.copyWith(
  //     name: event.field == "name" ? event.value : state.name,
  //     userName: event.field == "userName" ? event.value : state.userName,
  //     email: event.field == "email" ? event.value : state.email,
  //     mobile: event.field == "mobile" ? event.value : state.mobile,
  //     bio: event.field == "bio" ? event.value : state.bio,
  //     address: event.field == "address" ? event.value : state.address,
  //     dob: event.field == "dob" ? event.value : state.dob,
  //   ));
  // }

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
      // Simulate saving the data to a backend or a local database
      print('Profile submitted:');
      print('Name: ${event.name}');
      print('Username: ${event.userName}');
      print('Email: ${event.email}');
      print('Mobile: ${event.mobile}');
      print('Bio: ${event.bio}');
      print('Address: ${event.address}');
      print('DOB: ${event.dob}');
      print('Portfolio Title: ${event.portfolioTitle}');
      print('Portfolio Description: ${event.portfolioDescription}');
      print('Service 1: ${event.service1}');
      print('Service 2: ${event.service2}');

      await Future.delayed(Duration(seconds: 2));

      // Emit success state
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (error) {
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }
}
