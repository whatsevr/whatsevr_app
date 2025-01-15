import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_cover_media.dart';
import 'package:whatsevr_app/config/api/requests_model/update_user_profile_picture.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_educations.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_info.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_portfolio_info.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_services.dart';
import 'package:whatsevr_app/config/api/requests_model/user/update_user_work_experiences.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart'
    hide
        UserInfo,
        UserEducation,
        UserWorkExperience,
        UserService,
        UserCoverMedia;
import 'package:whatsevr_app/config/enums/activity_type.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/activity_track/activity_tracking.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/src/features/update_user_profile/views/page.dart';

part 'event.dart';
part 'state.dart';

class UserProfileUpdateBloc
    extends Bloc<UserProfileUpdateEvent, UserProfileUpdateState> {
  TextEditingController nameController = TextEditingController();

  TextEditingController publicEmailController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController portfolioTitle = TextEditingController();
  TextEditingController portfolioDescriptionController =
      TextEditingController();
  TextEditingController portfolioStatus = TextEditingController();

  UserProfileUpdateBloc() : super(const UserProfileUpdateState()) {
    on<InitialEvent>(_onInitialEvent);
    on<ChangeProfilePictureEvent>(_onChangeProfilePicture);
    on<AddOrRemoveCoverMedia>(_onAddOrRemoveCoverMedia);
    on<UpdateGender>(_onUpdateGender);
    on<AddOrRemoveEducation>(_onAddOrRemoveEducation);
    on<AddOrRemoveWorkExperience>(_onAddOrRemoveWorkExperience);
    on<AddOrRemoveService>(_onAddOrRemoveService);

    on<SubmitProfile>(_onSubmitProfile);
  }
  FutureOr<void> _onInitialEvent(
    InitialEvent event,
    Emitter<UserProfileUpdateState> emit,
  ) async {
    UserProfileDetailsResponse? profileDetailsResponse =
        event.pageArgument.profileDetailsResponse;
    if (profileDetailsResponse == null) {
      SmartDialog.showLoading();
      profileDetailsResponse = await UsersApi.getProfileDetails(
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
      );
      SmartDialog.dismiss();
    }
    emit(
      state.copyWith(
        currentProfileDetailsResponse: profileDetailsResponse,
        dob: profileDetailsResponse?.userInfo?.dob,
        gender: profileDetailsResponse?.userInfo?.gender,
        educations: List.generate(
          profileDetailsResponse?.userEducations?.length ?? 0,
          (int index) => UiEducation(
            degreeName: profileDetailsResponse?.userEducations?[index].title,
            degreeType: profileDetailsResponse?.userEducations?[index].type,
            startDate: profileDetailsResponse?.userEducations?[index].startDate,
            endDate: profileDetailsResponse?.userEducations?[index].endDate,
            isOngoingEducation: profileDetailsResponse
                ?.userEducations?[index].isOngoingEducation,
            institute: profileDetailsResponse?.userEducations?[index].institute,
          ),
        ),
        workExperiences: List.generate(
          profileDetailsResponse?.userWorkExperiences?.length ?? 0,
          (int index) => UiWorkExperience(
            designation:
                profileDetailsResponse?.userWorkExperiences?[index].designation,
            startDate:
                profileDetailsResponse?.userWorkExperiences?[index].startDate,
            endDate:
                profileDetailsResponse?.userWorkExperiences?[index].endDate,
            isCurrentlyWorking: profileDetailsResponse
                ?.userWorkExperiences?[index].isCurrentlyWorking,
            workingMode:
                profileDetailsResponse?.userWorkExperiences?[index].workingMode,
            companyName:
                profileDetailsResponse?.userWorkExperiences?[index].companyName,
          ),
        ),
        services: List.generate(
          profileDetailsResponse?.userServices?.length ?? 0,
          (int index) => UiService(
            serviceName: profileDetailsResponse?.userServices?[index].title,
            serviceDescription:
                profileDetailsResponse?.userServices?[index].description,
          ),
        ),
        coverMedia: List.generate(
          profileDetailsResponse?.userCoverMedia?.length ?? 0,
          (int index) => UiCoverMedia(
            imageUrl: profileDetailsResponse?.userCoverMedia?[index].imageUrl,
            videoUrl: profileDetailsResponse?.userCoverMedia?[index].videoUrl,
            isVideo: profileDetailsResponse?.userCoverMedia?[index].isVideo,
          ),
        ),
      ),
    );

    // Set the initial values of the text controllers
    nameController.text = profileDetailsResponse?.userInfo?.name ?? '';

    publicEmailController.text =
        profileDetailsResponse?.userInfo?.publicEmailId ?? '';

    bioController.text = profileDetailsResponse?.userInfo?.bio ?? '';
    addressController.text = profileDetailsResponse?.userInfo?.address ?? '';

    portfolioDescriptionController.text = event.pageArgument
            .profileDetailsResponse?.userInfo?.portfolioDescription ??
        '';
    portfolioStatus.text =
        profileDetailsResponse?.userInfo?.portfolioStatus ?? '';
    portfolioTitle.text =
        profileDetailsResponse?.userInfo?.portfolioTitle ?? '';
  }

  void _onChangeProfilePicture(
    ChangeProfilePictureEvent event,
    Emitter<UserProfileUpdateState> emit,
  ) async {
    try {
      if (event.profileImage == null) throw Exception('No image picked');
      emit(state.copyWith(profileImage: event.profileImage));
      final String? profilePictureUrl =
          await FileUploadService.uploadFilesToSupabase(
        event.profileImage!,
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
        fileRelatedTo: 'profile-picture',
        fileExtension: 'jpg',
      );
      await UsersApi.updateProfilePicture(
        ProfilePictureUpdateRequest(
          userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
          profilePictureUrl: profilePictureUrl,
        ),
      );
      ActivityLoggingService.log(
        activityType: WhatsevrActivityType.system,
        metadata: {'message': 'Profile picture changed'},
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
      if (kDebugMode) rethrow;
    }
  }

  void _onAddOrRemoveCoverMedia(
    AddOrRemoveCoverMedia event,
    Emitter<UserProfileUpdateState> emit,
  ) async {
    try {
      if (event.removableCoverMedia != null) {
        emit(
          state.copyWith(
            coverMedia: state.coverMedia?.where((UiCoverMedia element) {
              return element != event.removableCoverMedia;
            }).toList(),
          ),
        );
      }
      if (state.coverMedia?.length == 4) {
        SmartDialog.showToast('You can only add 4 cover media');
        return;
      }

      if (event.coverImage != null || event.coverVideo != null) {
        SmartDialog.showLoading();
        final File? imageFile = event.coverImage;
        final File? videoFile = event.coverVideo;
        final String? imageUrl = await FileUploadService.uploadFilesToSupabase(
          imageFile!,
          userUid: (AuthUserDb.getLastLoggedUserUid())!,
          fileRelatedTo: 'cover-image',
          fileExtension: 'jpg',
        );
        String? videoUrl;
        if (videoFile != null) {
          videoUrl = await FileUploadService.uploadFilesToSupabase(
            videoFile,
            userUid: (AuthUserDb.getLastLoggedUserUid())!,
            fileRelatedTo: 'cover-video',
          );
        }

        emit(
          state.copyWith(
            coverMedia: <UiCoverMedia>[
              ...state.coverMedia ?? [],
              UiCoverMedia(
                imageUrl: imageUrl,
                videoUrl: videoUrl,
                isVideo: videoUrl?.isNotEmpty ?? false,
              ),
            ],
          ),
        );
      }

      await UsersApi.updateCoverMedia(
        UpdateUserCoverMediaRequest(
          userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
          userCoverMedia: state.coverMedia
              ?.map(
                (UiCoverMedia e) => UserCoverMedia(
                  imageUrl: e.imageUrl,
                  videoUrl: e.videoUrl,
                  isVideo: e.videoUrl?.isNotEmpty ?? false,
                  userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
                ),
              )
              .toList(),
        ),
      );
      SmartDialog.dismiss();
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast(e.toString());
      if (kDebugMode) rethrow;
    }
  }

  FutureOr<void> _onUpdateGender(
    UpdateGender event,
    Emitter<UserProfileUpdateState> emit,
  ) {
    emit(state.copyWith(gender: event.gender));
  }

  FutureOr<void> _onAddOrRemoveEducation(
    AddOrRemoveEducation event,
    Emitter<UserProfileUpdateState> emit,
  ) {
    if (event.isRemove == true) {
      emit(
        state.copyWith(
          educations: state.educations?.where((UiEducation element) {
            return element != event.education;
          }).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          educations: <UiEducation>[
            ...state.educations ?? <UiEducation>[],
            event.education!,
          ],
        ),
      );
    }
  }

  FutureOr<void> _onAddOrRemoveWorkExperience(
    AddOrRemoveWorkExperience event,
    Emitter<UserProfileUpdateState> emit,
  ) {
    if (event.isRemove == true) {
      emit(
        state.copyWith(
          workExperiences:
              state.workExperiences?.where((UiWorkExperience element) {
            return element != event.workExperience;
          }).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          workExperiences: <UiWorkExperience>[
            ...state.workExperiences ?? <UiWorkExperience>[],
            event.workExperience!,
          ],
        ),
      );
    }
  }

  FutureOr<void> _onAddOrRemoveService(
    AddOrRemoveService event,
    Emitter<UserProfileUpdateState> emit,
  ) {
    if (event.isRemove == true) {
      emit(
        state.copyWith(
          services: state.services?.where((UiService element) {
            return element != event.service;
          }).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          services: <UiService>[
            ...state.services ?? <UiService>[],
            event.service!,
          ],
        ),
      );
    }
  }

  Future<void> _onSubmitProfile(
    SubmitProfile event,
    Emitter<UserProfileUpdateState> emit,
  ) async {
    try {
      if (nameController.text.isEmpty) {
        throw BusinessException('Name cannot be empty');
      }
      if (state.currentProfileDetailsResponse?.userInfo?.isPortfolio ?? false) {
        if (portfolioTitle.text.isEmpty) {
          throw BusinessException('Portfolio title cannot be empty');
        }
      }
      SmartDialog.showLoading();
      final UpdateUserInfoRequest newUpdateUserInfoRequest =
          UpdateUserInfoRequest(
        userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
        userInfo: UserInfo(
          name: nameController.text,
          bio: bioController.text,
          address: addressController.text,
          publicEmailId: publicEmailController.text,
          dob: state.dob,
          gender: state.gender,
        ),
      );
      (int?, String?)? userInfoUpdateResponse =
          await UsersApi.updateUserInfo(newUpdateUserInfoRequest);
      if (userInfoUpdateResponse?.$1 != HttpStatus.ok) {
        throw BusinessException(
          userInfoUpdateResponse?.$2 ?? 'Failed to update profile info',
        );
      }
      SmartDialog.showLoading(msg: '${userInfoUpdateResponse?.$2}');
      if (state.currentProfileDetailsResponse?.userInfo?.isPortfolio ?? false) {
        final UpdateUserPortfolioInfoRequest newUserPortfolioInfoRequest =
            UpdateUserPortfolioInfoRequest(
          userUid: state.currentProfileDetailsResponse?.userInfo?.uid,
          portfolioInfo: PortfolioInfo(
            portfolioStatus: portfolioStatus.text,
            portfolioDescription: portfolioDescriptionController.text,
            portfolioTitle: portfolioTitle.text,
          ),
        );
        (int?, String?)? portfolioUpdateResponse =
            await UsersApi.updateUserPortfolioInfo(newUserPortfolioInfoRequest);
        SmartDialog.showLoading(msg: '${portfolioUpdateResponse?.$2}');
      }
      final UpdateUserEducationsRequest newUserEducationsRequest =
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
      (int?, String?)? m2 =
          await UsersApi.updateEducations(newUserEducationsRequest);

      SmartDialog.showLoading(msg: '${m2?.$2}');
      final UpdateUserWorkExperiencesRequest newUserWorkExperiencesRequest =
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

      (int?, String?)? m3 =
          await UsersApi.updateWorkExperiences(newUserWorkExperiencesRequest);
      SmartDialog.showLoading(msg: '${m3?.$2}');
      if (state.currentProfileDetailsResponse?.userInfo?.isPortfolio ?? false) {
        final UpdateUserServicesRequest newUserServicesRequest =
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
        (int?, String?)? m4 =
            await UsersApi.updateServices(newUserServicesRequest);
        SmartDialog.showLoading(msg: '${m4?.$2}');
      }
      SmartDialog.dismiss();
      AppNavigationService.goBack();
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }
}
