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
  TextEditingController portfolioStatus = TextEditingController();

  ProfileBloc() : super(ProfileState()) {
    on<InitialEvent>(_onInitialEvent);
    on<ChangeProfilePictureEvent>(_onChangeProfilePicture);
    on<UploadCoverMediaEvent>(_onUploadCoverPicture);
    on<UpdateGender>(_onUpdateGender);
    on<AddOrRemoveEducation>(_onAddOrRemoveEducation);
    on<AddOrRemoveWorkExperience>(_onAddOrRemoveWorkExperience);

    on<SubmitProfile>(_onSubmitProfile);
  }
  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      currentProfileDetailsResponse: event.pageArgument.profileDetailsResponse,
      dob: event.pageArgument.profileDetailsResponse?.userInfo?.dob,
      gender: event.pageArgument.profileDetailsResponse?.userInfo?.gender,
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
    portfolioStatus.text =
        event.pageArgument.profileDetailsResponse?.userInfo?.portfolioStatus ??
            '';

    emit(state.copyWith(
      educations: List.generate(
        event.pageArgument.profileDetailsResponse?.userEducations?.length ?? 0,
        (index) => UiEducation(
          degreeName: event.pageArgument.profileDetailsResponse
              ?.userEducations?[index].title,
          degreeType: event
              .pageArgument.profileDetailsResponse?.userEducations?[index].type,
          startDate: event.pageArgument.profileDetailsResponse
              ?.userEducations?[index].startDate,
          endDate: event.pageArgument.profileDetailsResponse
              ?.userEducations?[index].endDate,
          isOngoingEducation: event.pageArgument.profileDetailsResponse
              ?.userEducations?[index].isOngoingEducation,
          institute: event.pageArgument.profileDetailsResponse
              ?.userEducations?[index].institute,
        ),
      ),
    ));
    emit(state.copyWith(
        workExperiences: List.generate(
      event.pageArgument.profileDetailsResponse?.userWorkExperiences?.length ??
          0,
      (index) => UiWorkExperience(
        designation: event.pageArgument.profileDetailsResponse
            ?.userWorkExperiences?[index].designation,
        startDate: event.pageArgument.profileDetailsResponse
            ?.userWorkExperiences?[index].startDate,
        endDate: event.pageArgument.profileDetailsResponse
            ?.userWorkExperiences?[index].endDate,
        isCurrentlyWorking: event.pageArgument.profileDetailsResponse
            ?.userWorkExperiences?[index].isCurrentlyWorking,
        workingMode: event.pageArgument.profileDetailsResponse
            ?.userWorkExperiences?[index].workingMode,
      ),
    )));
    emit(state.copyWith(
      services: List.generate(
        event.pageArgument.profileDetailsResponse?.userServices?.length ?? 0,
        (index) => UiService(
          serviceName: event
              .pageArgument.profileDetailsResponse?.userServices?[index].title,
          serviceDescription: event.pageArgument.profileDetailsResponse
              ?.userServices?[index].description,
        ),
      ),
    ));
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
      UploadCoverMediaEvent event, Emitter<ProfileState> emit) {
    //
    // emit(state.copyWith(coverImages: Li));
  }

  FutureOr<void> _onUpdateGender(
      UpdateGender event, Emitter<ProfileState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  FutureOr<void> _onAddOrRemoveEducation(
      AddOrRemoveEducation event, Emitter<ProfileState> emit) {
    if (event.isRemove == true) {
      emit(state.copyWith(
        educations: state.educations?.where((element) {
          return element != event.education;
        }).toList(),
      ));
    } else {
      emit(state.copyWith(
        educations: [
          ...state.educations ?? [],
          UiEducation(
            degreeName: event.education?.degreeName,
            degreeType: event.education?.degreeType,
            startDate: event.education?.startDate,
            endDate: event.education?.endDate,
            isOngoingEducation: event.education?.isOngoingEducation,
            institute: event.education?.institute,
          ),
        ],
      ));
    }
  }

  FutureOr<void> _onAddOrRemoveWorkExperience(
      AddOrRemoveWorkExperience event, Emitter<ProfileState> emit) {}

  Future<void> _onSubmitProfile(
      SubmitProfile event, Emitter<ProfileState> emit) async {}
}
