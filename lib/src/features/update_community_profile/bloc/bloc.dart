import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/requests_model/community/update_community_cover_media.dart';
import 'package:whatsevr_app/config/api/requests_model/community/update_community_info.dart';
import 'package:whatsevr_app/config/api/requests_model/community/update_community_profile_picture.dart';
import 'package:whatsevr_app/config/api/requests_model/community/update_community_services.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_details.dart'
    hide CommunityInfo, CommunityService, CommunityCoverMedia;
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/src/features/update_community_profile/views/page.dart';

part 'event.dart';
part 'state.dart';

class CommunityProfileUpdateBloc
    extends Bloc<CommunityProfileUpdateEvent, CommunityProfileUpdateState> {
  TextEditingController titleController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController portfolioStatus = TextEditingController();

  CommunityProfileUpdateBloc() : super(const CommunityProfileUpdateState()) {
    on<InitialEvent>(_onInitialEvent);
    on<ChangeProfilePictureEvent>(_onChangeProfilePicture);
    on<AddOrRemoveCoverMedia>(_onAddOrRemoveCoverMedia);
    on<AddOrRemoveService>(_onAddOrRemoveService);

    on<SubmitProfile>(_onSubmitProfile);
  }
  FutureOr<void> _onInitialEvent(
    InitialEvent event,
    Emitter<CommunityProfileUpdateState> emit,
  ) {
    emit(
      state.copyWith(
        currentProfileDetailsResponse:
            event.pageArgument.profileDetailsResponse,
        services: List.generate(
          event.pageArgument.profileDetailsResponse?.communityServices
                  ?.length ??
              0,
          (int index) => UiService(
            serviceName: event.pageArgument.profileDetailsResponse
                ?.communityServices?[index].title,
            serviceDescription: event.pageArgument.profileDetailsResponse
                ?.communityServices?[index].description,
          ),
        ),
        coverMedia: List.generate(
          event.pageArgument.profileDetailsResponse?.communityCoverMedia
                  ?.length ??
              0,
          (int index) => UiCoverMedia(
            imageUrl: event.pageArgument.profileDetailsResponse
                ?.communityCoverMedia?[index].imageUrl,
            videoUrl: event.pageArgument.profileDetailsResponse
                ?.communityCoverMedia?[index].videoUrl,
            isVideo: event.pageArgument.profileDetailsResponse
                ?.communityCoverMedia?[index].isVideo,
          ),
        ),
      ),
    );

    // Set the initial values of the text controllers
    titleController.text =
        event.pageArgument.profileDetailsResponse?.communityInfo?.title ?? '';

    bioController.text =
        event.pageArgument.profileDetailsResponse?.communityInfo?.bio ?? '';
    addressController.text =
        event.pageArgument.profileDetailsResponse?.communityInfo?.location ??
            '';

    portfolioStatus.text =
        event.pageArgument.profileDetailsResponse?.communityInfo?.status ?? '';
  }

  void _onChangeProfilePicture(
    ChangeProfilePictureEvent event,
    Emitter<CommunityProfileUpdateState> emit,
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
      await CommunityApi.updateCommunityProfilePicture(
        request: CommunityProfilePictureUpdateRequest(
          userUid: state.currentProfileDetailsResponse?.communityInfo?.uid,
          profilePictureUrl: profilePictureUrl,
        ),
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
      if (kDebugMode) rethrow;
    }
  }

  void _onAddOrRemoveCoverMedia(
    AddOrRemoveCoverMedia event,
    Emitter<CommunityProfileUpdateState> emit,
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

      await CommunityApi.updateCommunityCoverMedia(
        request: UpdateCommunityCoverMediaRequest(
          communityUid: state.currentProfileDetailsResponse?.communityInfo?.uid,
          userUid: AuthUserDb.getLastLoggedUserUid(),
          communityCoverMedia: state.coverMedia
              ?.map(
                (UiCoverMedia e) => CommunityCoverMedia(
                  imageUrl: e.imageUrl,
                  videoUrl: e.videoUrl,
                  isVideo: e.videoUrl?.isNotEmpty ?? false,
                  communityUid:
                      state.currentProfileDetailsResponse?.communityInfo?.uid,
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

  FutureOr<void> _onAddOrRemoveService(
    AddOrRemoveService event,
    Emitter<CommunityProfileUpdateState> emit,
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
    Emitter<CommunityProfileUpdateState> emit,
  ) async {
    try {
      if (titleController.text.isEmpty) {
        throw BusinessException('Title cannot be empty');
      }

      SmartDialog.showLoading();
      final UpdateCommunityInfoRequest newUpdateUserInfoRequest =
          UpdateCommunityInfoRequest(
        communityUid: state.currentProfileDetailsResponse?.communityInfo?.uid,
        userUid: AuthUserDb.getLastLoggedUserUid(),
        communityInfo: CommunityInfo(
          title: titleController.text,
          bio: bioController.text,
          location: addressController.text,
        ),
      );
      (int?, String?)? userInfoUpdateResponse =
          await CommunityApi.updateCommunityInfo(
              request: newUpdateUserInfoRequest);
      if (userInfoUpdateResponse?.$1 != HttpStatus.ok) {
        throw BusinessException(
          userInfoUpdateResponse?.$2 ?? 'Failed to update profile info',
        );
      }
      SmartDialog.showLoading(msg: '${userInfoUpdateResponse?.$2}');

      final UpdateCommunityServicesRequest newUserServicesRequest =
          UpdateCommunityServicesRequest(
        communityUid: state.currentProfileDetailsResponse?.communityInfo?.uid,
        userUid: AuthUserDb.getLastLoggedUserUid(),
        communityServices: state.services
            ?.map(
              (UiService e) => CommunityService(
                communityUid:
                    state.currentProfileDetailsResponse?.communityInfo?.uid,
                title: e.serviceName,
                description: e.serviceDescription,
              ),
            )
            .toList(),
      );
      (int?, String?)? m4 = await CommunityApi.updateCommunityServices(
          request: newUserServicesRequest);
      SmartDialog.showLoading(msg: '${m4?.$2}');
      SmartDialog.dismiss();
      AppNavigationService.goBack();
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }
}
