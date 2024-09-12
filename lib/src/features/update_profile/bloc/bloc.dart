import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/requests_model/upadate_user_work_experiences.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_educations.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_services.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart'
    hide UserInfo, UserEducation, UserWorkExperience, UserService;
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/src/features/update_profile/views/page.dart';

import 'package:whatsevr_app/config/api/requests_model/update_profile_picture.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_info.dart';
part 'event.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController portfolioTitle = TextEditingController();
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
    on<AddOrRemoveService>(_onAddOrRemoveService);

    on<SubmitProfile>(_onSubmitProfile);
  }
  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<ProfileState> emit,) {
    emit(state.copyWith(
      currentProfileDetailsResponse: event.pageArgument.profileDetailsResponse,
      dob: event.pageArgument.profileDetailsResponse?.userInfo?.dob,
      gender: event.pageArgument.profileDetailsResponse?.userInfo?.gender,
    ),);

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
    portfolioTitle.text =
        event.pageArgument.profileDetailsResponse?.userInfo?.portfolioTitle ??
            '';
    emit(state.copyWith(
      educations: List.generate(
        event.pageArgument.profileDetailsResponse?.userEducations?.length ?? 0,
        (int index) => UiEducation(
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
    ),);
    emit(state.copyWith(
        workExperiences: List.generate(
      event.pageArgument.profileDetailsResponse?.userWorkExperiences?.length ??
          0,
      (int index) => UiWorkExperience(
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
        companyName: event.pageArgument.profileDetailsResponse
            ?.userWorkExperiences?[index].companyName,
      ),
    ),),);
    emit(state.copyWith(
      services: List.generate(
        event.pageArgument.profileDetailsResponse?.userServices?.length ?? 0,
        (int index) => UiService(
          serviceName: event
              .pageArgument.profileDetailsResponse?.userServices?[index].title,
          serviceDescription: event.pageArgument.profileDetailsResponse
              ?.userServices?[index].description,
        ),
      ),
    ),);
  }

  final ImagePicker _picker = ImagePicker();
  void _onChangeProfilePicture(
      ChangeProfilePictureEvent event, Emitter<ProfileState> emit,) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (pickedFile == null) return;
    emit(state.copyWith(profileImage: File(pickedFile.path)));
    String? profilePictureUrl = await FileUploadService.uploadFilesToSST(
      state.profileImage!,
    );
    await UsersApi.updateProfilePicture(
      ProfilePictureUpdateRequest(
        userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
        profilePictureUrl: profilePictureUrl,
      ),
    );
  }

  void _onUploadCoverPicture(
      UploadCoverMediaEvent event, Emitter<ProfileState> emit,) {
    //
    // emit(state.copyWith(coverImages: Li));
  }

  FutureOr<void> _onUpdateGender(
      UpdateGender event, Emitter<ProfileState> emit,) {
    emit(state.copyWith(gender: event.gender));
  }

  FutureOr<void> _onAddOrRemoveEducation(
      AddOrRemoveEducation event, Emitter<ProfileState> emit,) {
    if (event.isRemove == true) {
      emit(state.copyWith(
        educations: state.educations?.where((UiEducation element) {
          return element != event.education;
        }).toList(),
      ),);
    } else {
      emit(state.copyWith(
        educations: <UiEducation>[
          ...state.educations ?? <UiEducation>[],
          event.education!,
        ],
      ),);
    }
  }

  FutureOr<void> _onAddOrRemoveWorkExperience(
      AddOrRemoveWorkExperience event, Emitter<ProfileState> emit,) {
    if (event.isRemove == true) {
      emit(state.copyWith(
        workExperiences: state.workExperiences?.where((UiWorkExperience element) {
          return element != event.workExperience;
        }).toList(),
      ),);
    } else {
      emit(state.copyWith(
        workExperiences: <UiWorkExperience>[
          ...state.workExperiences ?? <UiWorkExperience>[],
          event.workExperience!,
        ],
      ),);
    }
  }

  FutureOr<void> _onAddOrRemoveService(
      AddOrRemoveService event, Emitter<ProfileState> emit,) {
    if (event.isRemove == true) {
      emit(state.copyWith(
        services: state.services?.where((UiService element) {
          return element != event.service;
        }).toList(),
      ),);
    } else {
      emit(state.copyWith(
        services: <UiService>[
          ...state.services ?? <UiService>[],
          event.service!,
        ],
      ),);
    }
  }

  Future<void> _onSubmitProfile(
      SubmitProfile event, Emitter<ProfileState> emit,) async {
    try {
      SmartDialog.showLoading();
      UpdateUserInfoRequest newUpdateUserInfoRequest = UpdateUserInfoRequest(
        userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
        userInfo: UserInfo(
          name: nameController.text,
          bio: bioController.text,
          address: addressController.text,
          portfolioStatus: portfolioStatus.text,
          portfolioDescription: portfolioDescriptionController.text,
          portfolioTitle: portfolioTitle.text,
          emailId: emailController.text,
          dob: state.dob,
          gender: state.gender,
        ),
      );
      UpdateUserEducationsRequest newUserEducationsRequest =
          UpdateUserEducationsRequest(
        userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
        userEducations: state.educations
            ?.map(
              (UiEducation e) => UserEducation(
                userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
                title: e.degreeName,
                type: e.degreeType,
                startDate: e.startDate,
                endDate: e.endDate,
                isOngoingEducation: e.isOngoingEducation,
                institute: e.institute,
              ),
            )
            .toList(),
      );
      UpdateUserWorkExperiencesRequest newUserWorkExperiencesRequest =
          UpdateUserWorkExperiencesRequest(
        userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
        userWorkExperiences: state.workExperiences
            ?.map(
              (UiWorkExperience e) => UserWorkExperience(
                userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
                designation: e.designation,
                startDate: e.startDate,
                endDate: e.endDate,
                isCurrentlyWorking: e.isCurrentlyWorking,
                workingMode: e.workingMode,
                companyName: e.companyName,
              ),
            )
            .toList(),
      );
      UpdateUserServicesRequest newUserServicesRequest =
          UpdateUserServicesRequest(
        userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
        userServices: state.services
            ?.map(
              (UiService e) => UserService(
                userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
                title: e.serviceName,
                description: e.serviceDescription,
              ),
            )
            .toList(),
      );
      String? m1 = await UsersApi.updateUserInfo(newUpdateUserInfoRequest);
      SmartDialog.showLoading(msg: '$m1');
      String? m2 = await UsersApi.updateEducations(newUserEducationsRequest);
      SmartDialog.showLoading(msg: '$m2');
      String? m3 =
          await UsersApi.updateWorkExperiences(newUserWorkExperiencesRequest);
      SmartDialog.showLoading(msg: '$m3');
      String? m4 = await UsersApi.updateServices(newUserServicesRequest);
      SmartDialog.showLoading(msg: '$m4');
      SmartDialog.dismiss();
      AppNavigationService.goBack();
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast(e.toString());
      if (kDebugMode) rethrow;
    }
  }
}
