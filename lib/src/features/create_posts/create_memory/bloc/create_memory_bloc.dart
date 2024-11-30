import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/detector/text_pattern_detector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/places_nearby.dart';
import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/create_memory.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_memory.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/media/meta_data.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';
import 'package:whatsevr_app/src/features/create_posts/create_memory/views/page.dart';

part 'create_memory_event.dart';
part 'create_memory_state.dart';

class CreateMemoryBloc extends Bloc<CreateMemoryEvent, CreateMemoryState> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController ctaActionUrlController = TextEditingController();

  CreateMemoryBloc() : super(const CreateMemoryState()) {
    on<CreateMemoryInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);
    on<PickVideoEvent>(_onPickVideo);
    on<PickThumbnailEvent>(_onPickThumbnail);
    on<PickImageEvent>(_onPickImage);
    on<UpdatePostAddressEvent>(_onUpdatePostAddress);
    on<UpdateTaggedUsersAndCommunitiesEvent>(
      _onUpdateTaggedUsersAndCommunities,
    );
    on<RemoveVideoOrImageEvent>(_onRemoveVideoOrImage);
    on<CreateVideoMemoryEvent>(_onCreateVideoMemory);
    on<CreateImageMemoryEvent>(_onCreateImageMemory);
    on<UpdateCtaActionEvent>(_onUpdateCtaAction);
    on<UpdateNoOfDaysEvent>(_onUpdateNoOfDays);
  }
  FutureOr<void> _onInitial(
    CreateMemoryInitialEvent event,
    Emitter<CreateMemoryState> emit,
  ) async {
    try {
      emit(state.copyWith(
        postCreatorType: event.pageArgument.postCreatorType,
        communityUid: event.pageArgument.communityUid,
      ));

      PlacesNearbyResponse? placesNearbyResponse;
      await LocationService.getNearByPlacesFromLatLong(
        onCompleted: (
          nearbyPlacesResponse,
          lat,
          long,
          isDeviceGpsEnabled,
          isPermissionAllowed,
        ) {
          placesNearbyResponse = nearbyPlacesResponse;
          if (lat != null && long != null) {
            emit(
              state.copyWith(
                userCurrentLocationLatLongWkb:
                    WKBUtil.getWkbString(lat: lat, long: long),
              ),
            );
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
    Emitter<CreateMemoryState> emit,
  ) async {
    try {
      if (state.imageFile == null && state.videoFile == null) {
        throw BusinessException('Please select an image or video');
      }
      captionController.text = captionController.text.trim();
      final String hashtagsArea = captionController.text;
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
      if (captionController.text.isEmpty) {
        throw BusinessException('Caption is required');
      }
      SmartDialog.showLoading(msg: 'Validating post...');
      //Sanity check
      (String?, int?)? itm = await PostApi.sanityCheckNewMemory(
        request: SanityCheckNewMemoryRequest(
          mediaMetaData: MediaMetaData(
            videoDurationSec: state.videoMetaData?.durationInSec,
            sizeBytes: state.videoMetaData?.sizeInBytes,
          ),
          postData: PostData(
            isVideo: state.isVideoMemory,
            isImage: state.isImageMemory,
            userUid: AuthUserDb.getLastLoggedUserUid(),
            postCreatorType: state.postCreatorType?.value,
              communityUid:  state.communityUid,
          ),
        ),
      );
      if (itm?.$2 != 200) {
        throw BusinessException(itm!.$1!);
      }

      //create video memory
      if (state.isVideoMemory == true) {
        add(
          CreateVideoMemoryEvent(
            hashtags: hashtags,
          ),
        );
      } else if (state.isImageMemory == true) {
        add(
          CreateImageMemoryEvent(
            hashtags: hashtags,
          ),
        );
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onPickVideo(
    PickVideoEvent event,
    Emitter<CreateMemoryState> emit,
  ) async {
    try {
      if (event.pickVideoFile == null) return;
      SmartDialog.showLoading(msg: 'Validating video...');
      final FileMetaData? videoMetaData =
          await FileMetaData.fromFile(event.pickVideoFile);
      // Validate video metadata
      if (videoMetaData == null || videoMetaData.isVideo != true) {
        throw BusinessException('Invalid video file');
      }

      emit(
        state.copyWith(
          videoFile: event.pickVideoFile,
          isVideoMemory: true,
          isImageMemory: false,
        ),
      );

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
    Emitter<CreateMemoryState> emit,
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
    UpdatePostAddressEvent event,
    Emitter<CreateMemoryState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          selectedAddress: event.address,
          selectedAddressLatLongWkb: WKBUtil.getWkbString(
            lat: event.addressLatitude,
            long: event.addressLongitude,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onUpdateTaggedUsersAndCommunities(
    UpdateTaggedUsersAndCommunitiesEvent event,
    Emitter<CreateMemoryState> emit,
  ) {
    try {
      if (event.clearAll == true) {
        emit(
          state.copyWith(
            taggedUsersUid: [],
            taggedCommunitiesUid: [],
          ),
        );
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
        emit(
          state.copyWith(
            taggedUsersUid: taggedUsersUid,
            taggedCommunitiesUid: taggedCommunitiesUid,
          ),
        );
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onPickImage(
    PickImageEvent event,
    Emitter<CreateMemoryState> emit,
  ) async {
    try {
      if (event.pickedImageFile == null) return;
      emit(
        state.copyWith(
          imageFile: event.pickedImageFile,
          isImageMemory: true,
          isVideoMemory: false,
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onRemoveVideoOrImage(
    RemoveVideoOrImageEvent event,
    Emitter<CreateMemoryState> emit,
  ) {
    emit(
      CreateMemoryState(
        communityUid:  state.communityUid,
        postCreatorType: state.postCreatorType,
        userCurrentLocationLatLongWkb: state.userCurrentLocationLatLongWkb,
        selectedAddress: state.selectedAddress,
        selectedAddressLatLongWkb: state.selectedAddressLatLongWkb,
        taggedUsersUid: state.taggedUsersUid,
        taggedCommunitiesUid: state.taggedCommunitiesUid,
        ctaAction: state.ctaAction,
        placesNearbyResponse: state.placesNearbyResponse,
      ),
    );
  }

  FutureOr<void> _onCreateVideoMemory(
    CreateVideoMemoryEvent event,
    Emitter<CreateMemoryState> emit,
  ) async {
    try {
      if (state.videoFile == null) {
        throw BusinessException('Please select a video first');
      }
      if (state.thumbnailFile == null) {
        throw BusinessException('Please select a thumbnail for video');
      }
      SmartDialog.showLoading(msg: 'Uploading video...');
      final String? videoUrl = await FileUploadService.uploadFilesToSupabase(
        state.videoFile!,
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
        fileRelatedTo: 'memory-video',
      );
      final String? thumbnailUrl =
          await FileUploadService.uploadFilesToSupabase(
        state.thumbnailFile!,
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
        fileRelatedTo: 'memory-image',
      );
      SmartDialog.showLoading(msg: 'Creating memory...');
      (String? message, int? statusCode)? response = await PostApi.createMemory(
        post: CreateMemoryRequest(
          isVideo: true,
          caption: captionController.text,
          userUid: AuthUserDb.getLastLoggedUserUid(),
          hashtags: event.hashtags.isEmpty
              ? null
              : event.hashtags.map((e) => e.replaceAll('#', '')).toList(),
          location: state.selectedAddress,
          postCreatorType: state.postCreatorType?.value,
          imageUrl: thumbnailUrl,
          videoUrl: videoUrl,
          videoDurationMs: state.videoMetaData?.durationInMs,
          ctaAction:
              ctaActionUrlController.text.isEmpty ? null : state.ctaAction,
          ctaActionUrl: state.ctaAction?.isNotEmpty ?? false
              ? ctaActionUrlController.text
              : null,
          expiresAt: DateTime.now().add(Duration(days: state.noOfDays ?? 1)),
          addressLatLongWkb: state.selectedAddressLatLongWkb,
          creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
          taggedUserUids: state.taggedUsersUid,
          taggedCommunityUids: state.taggedCommunitiesUid,
          communityUid: state.communityUid,
        ),
      );
      if (response != null) {
        SmartDialog.dismiss();
        SmartDialog.showToast('${response.$1}');
        AppNavigationService.goBack();
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onCreateImageMemory(
    CreateImageMemoryEvent event,
    Emitter<CreateMemoryState> emit,
  ) async {
    try {
      if (state.imageFile == null) {
        throw BusinessException('Please select an image first');
      }
      SmartDialog.showLoading(msg: 'Uploading image...');
      final String? imageUrl = await FileUploadService.uploadFilesToSupabase(
        state.imageFile!,
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
        fileRelatedTo: 'memory-image',
      );
      SmartDialog.showLoading(msg: 'Creating memory...');
      (String? message, int? statusCode)? response = await PostApi.createMemory(
        post: CreateMemoryRequest(
          isImage: true,
          caption: captionController.text,
          userUid: AuthUserDb.getLastLoggedUserUid(),
          hashtags: event.hashtags.isEmpty
              ? null
              : event.hashtags.map((e) => e.replaceAll('#', '')).toList(),
          location: state.selectedAddress,
          postCreatorType: state.postCreatorType?.value,
          imageUrl: imageUrl,
          ctaAction:
              ctaActionUrlController.text.isEmpty ? null : state.ctaAction,
          ctaActionUrl: state.ctaAction?.isNotEmpty ?? false
              ? ctaActionUrlController.text
              : null,
          expiresAt: DateTime.now().add(Duration(days: state.noOfDays ?? 1)),
          addressLatLongWkb: state.selectedAddressLatLongWkb,
          creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
          taggedUserUids: state.taggedUsersUid,
          taggedCommunityUids: state.taggedCommunitiesUid,
        ),
      );
      if (response != null) {
        SmartDialog.dismiss();
        SmartDialog.showToast('${response.$1}');
        AppNavigationService.goBack();
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onUpdateCtaAction(
    UpdateCtaActionEvent event,
    Emitter<CreateMemoryState> emit,
  ) {
    emit(state.copyWith(ctaAction: event.ctaAction));
  }

  FutureOr<void> _onUpdateNoOfDays(
    UpdateNoOfDaysEvent event,
    Emitter<CreateMemoryState> emit,
  ) {
    emit(state.copyWith(noOfDays: event.noOfDays));
  }
}
