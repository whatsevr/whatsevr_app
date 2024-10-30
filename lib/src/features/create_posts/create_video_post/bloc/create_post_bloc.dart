import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/detector/text_pattern_detector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../../../config/api/external/models/business_validation_exception.dart';
import '../../../../../config/api/external/models/places_nearby.dart';
import '../../../../../config/api/methods/posts.dart';
import '../../../../../config/api/requests_model/create_video_post.dart';
import '../../../../../config/api/requests_model/sanity_check_new_video_post.dart';
import '../../../../../config/routes/router.dart';
import '../../../../../config/services/auth_db.dart';
import '../../../../../config/services/file_upload.dart';
import '../../../../../config/services/location.dart';
import '../../../../../config/services/long_running_task/controller.dart';
import '../../../../../config/services/long_running_task/task_models/posts.dart';
import '../../../../../config/widgets/media/aspect_ratio.dart';
import '../../../../../config/widgets/media/meta_data.dart';
import '../../../../../config/widgets/media/thumbnail_selection.dart';
import '../../../../../utils/geopoint_wkb_parser.dart';
import '../views/page.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreateVideoPostBloc
    extends Bloc<CreateVideoPostEvent, CreateVideoPostState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController hashtagsController = TextEditingController();

  CreateVideoPostBloc() : super(const CreateVideoPostState()) {
    on<CreatePostInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);
    on<PickVideoEvent>(_onPickVideo);
    on<PickThumbnailEvent>(_onPickThumbnail);
    on<UpdatePostAddressEvent>(_onUpdatePostAddress);
    on<UpdateTaggedUsersAndCommunitiesEvent>(
        _onUpdateTaggedUsersAndCommunities,);
  }
  FutureOr<void> _onInitial(
    CreatePostInitialEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    try {
      emit(state.copyWith(pageArgument: event.pageArgument));

      PlacesNearbyResponse? placesNearbyResponse;
      await LocationService.getNearByPlacesFromLatLong(
        onCompleted: (nearbyPlacesResponse, lat, long, isDeviceGpsEnabled,
            isPermissionAllowed,) {
          placesNearbyResponse = nearbyPlacesResponse;
          if (lat != null && long != null) {
            emit(state.copyWith(
              userCurrentLocationLatLongWkb:
                  WKBUtil.getWkbString(lat: lat, long: long),
            ),);
          }
        },
      );
      emit(state.copyWith(placesNearbyResponse: placesNearbyResponse));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    try {
      titleController.text = titleController.text.trim();
      descriptionController.text = descriptionController.text.trim();
      final String hashtagsArea =
          '${titleController.text} ${hashtagsController.text}';
      List<String> hashtags = [];
      if (TextPatternDetector.isDetected(hashtagsArea, hashTagRegExp)) {
        hashtags = TextPatternDetector.extractDetections(
          hashtagsArea,
          hashTagRegExp,
        );
      }
      if (hashtags.length > 30) {
        throw BusinessException('Hashtags should not exceed 30');
      }
      if (titleController.text.isEmpty) {
        throw BusinessException('Title is required');
      }

      SmartDialog.showLoading();
      //Sanity check
      (String?, int?)? itm = await PostApi.sanityCheckNewVideoPost(
          request: SanityCheckNewVideoPostRequest(
              mediaMetaData: MediaMetaData(
                aspectRatio: state.videoMetaData?.aspectRatio,
                durationSec: state.videoMetaData?.durationInSec,
                sizeBytes: state.videoMetaData?.sizeInBytes,
              ),
              postData: PostData(
                userUid: AuthUserDb.getLastLoggedUserUid(),
                postCreatorType: state.pageArgument?.postCreatorType.value,
              ),),);
      if (itm?.$2 != 200) {
        throw BusinessException(itm!.$1!);
      }

      WhatsevrLongTaskController.startServiceWithTaskData(
          taskData: VideoPostTaskDataForLRT(
            videoFilePath: state.videoFile!.path,
            thumbnailFilePath: state.thumbnailFile!.path,
            title: titleController.text,
            description: descriptionController.text,
            userUid: (AuthUserDb.getLastLoggedUserUid())!,
            hashtags: hashtags.isEmpty
                ? null
                : hashtags.map((e) => e.replaceAll('#', '')).toList(),
            location: state.selectedPostLocation,
            postCreatorType: state.pageArgument?.postCreatorType.value,
            addressLatLongWkb: state.selectedPostLocationLatLongWkb,
            creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
            taggedUserUids: state.taggedUsersUid,
            taggedCommunityUids: state.taggedCommunitiesUid,
            videoDurationInSec: state.videoMetaData?.durationInSec,
          ),
          onTaskAssignFail: () async {
            SmartDialog.showLoading();
            final String? videoUrl =
                await FileUploadService.uploadFilesToSupabase(
              state.videoFile!,
              userUid: (AuthUserDb.getLastLoggedUserUid())!,
              fileRelatedTo: 'video-post',
            );
            final String? thumbnailUrl =
                await FileUploadService.uploadFilesToSupabase(
              state.thumbnailFile!,
              userUid: (AuthUserDb.getLastLoggedUserUid())!,
              fileRelatedTo: 'video-post-thumbnail',
            );
            (String? message, int? statusCode)? response =
                await PostApi.createVideoPost(
              post: CreateVideoPostRequest(
                title: titleController.text,
                description: descriptionController.text,
                userUid: AuthUserDb.getLastLoggedUserUid(),
                hashtags: hashtags.isEmpty
                    ? null
                    : hashtags.map((e) => e.replaceAll('#', '')).toList(),
                location: state.selectedPostLocation,
                postCreatorType: state.pageArgument?.postCreatorType.value,
                thumbnail: thumbnailUrl,
                videoUrl: videoUrl,
                addressLatLongWkb: state.selectedPostLocationLatLongWkb,
                creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
                taggedUserUids: state.taggedUsersUid,
                taggedCommunityUids: state.taggedCommunitiesUid,
                videoDurationInSec: state.videoMetaData?.durationInSec,
              ),
            );
            if (response?.$2 == 200) {
              SmartDialog.dismiss();
              SmartDialog.showToast('${response?.$1}');
              AppNavigationService.goBack();
            }
          },
          onTaskAssigned: () {
            SmartDialog.dismiss();
            SmartDialog.showToast('Creating post, do not close the app');
            AppNavigationService.goBack();
          },);
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onPickVideo(
    PickVideoEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    try {
      if (event.pickVideoFile == null) return;
      SmartDialog.showLoading(msg: 'Validating video...');
      final FileMetaData? videoMetaData =
          await FileMetaData.fromFile(event.pickVideoFile);
      // Validate video metadata
      if (videoMetaData == null ||
          videoMetaData.isVideo != true ||
          videoMetaData.aspectRatio?.isAspectRatioLandscapeOrSquare != true) {
        throw BusinessException(
            'Video is not valid, it must be landscape or square',);
      }

      emit(state.copyWith(videoFile: event.pickVideoFile));

      final File? thumbnailFile =
          await getThumbnailFile(videoFile: event.pickVideoFile!);

      final FileMetaData? thumbnailMetaData =
          await FileMetaData.fromFile(thumbnailFile);

      emit(
        state.copyWith(
          thumbnailFile: thumbnailFile,
          videoMetaData: videoMetaData,
          thumbnailMetaData: thumbnailMetaData,
        ),
      );
      SmartDialog.dismiss();
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  Future<void> _onPickThumbnail(
    PickThumbnailEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    try {
      // Check if videoFile is null, return early if it is
      if (state.videoFile == null) {
        // Handle the null case (e.g., show a toast or log an error)
        throw BusinessException('Please select a video first');
      }

      // If no thumbnail was selected, return early
      if (event.pickedThumbnailFile == null) {
        throw BusinessException('No thumbnail selected');
      }

      // Emit state changes after the thumbnail has been selected
      emit(
        state.copyWith(
          thumbnailFile: event.pickedThumbnailFile,
          thumbnailMetaData:
              await FileMetaData.fromFile(event.pickedThumbnailFile!),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  Future<void> _onUpdatePostAddress(
      UpdatePostAddressEvent event, Emitter<CreateVideoPostState> emit,) async {
    try {
      emit(
        state.copyWith(
          selectedPostLocation: event.address,
          selectedPostLocationLatLongWkb: WKBUtil.getWkbString(
              lat: event.addressLatitude, long: event.addressLongitude,),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onUpdateTaggedUsersAndCommunities(
      UpdateTaggedUsersAndCommunitiesEvent event,
      Emitter<CreateVideoPostState> emit,) {
    try {
      if (event.clearAll == true) {
        emit(state.copyWith(
          taggedUsersUid: [],
          taggedCommunitiesUid: [],
        ),);
      } else {
        List<String> taggedUsersUid = [
          ...state.taggedUsersUid,
          ...?event.taggedUsersUid,
        ];
        List<String> taggedCommunitiesUid = [
          ...state.taggedCommunitiesUid,
          ...?event.taggedCommunitiesUid,
        ];
        taggedUsersUid = taggedUsersUid.toSet().toList();
        taggedCommunitiesUid = taggedCommunitiesUid.toSet().toList();
        emit(state.copyWith(
          taggedUsersUid: taggedUsersUid,
          taggedCommunitiesUid: taggedCommunitiesUid,
        ),);
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }
}
