import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:detectable_text_field/detector/text_pattern_detector.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/places_nearby.dart';
import 'package:whatsevr_app/config/api/response_model/create_video_post.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';
import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreateVideoPostBloc
    extends Bloc<CreateVideoPostEvent, CreateVideoPostState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController hashtagsController = TextEditingController();

  CreateVideoPostBloc() : super(CreateVideoPostState()) {
    on<CreatePostInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);
    on<PickVideoEvent>(_onPickVideo);
    on<PickThumbnailEvent>(_onPickThumbnail);
    on<UpdatePostAddressEvent>(_onUpdatePostAddress);
    on<UpdateTaggedUsersAndCommunitiesEvent>(
        _onUpdateTaggedUsersAndCommunities);
  }
  FutureOr<void> _onInitial(
    CreatePostInitialEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    emit(state.copyWith(pageArgument: event.pageArgument));
    add(PickVideoEvent());
    PlacesNearbyResponse? placesNearbyResponse;
    await LocationService.getNearByPlacesFromLatLong(
      onCompleted: (nearbyPlacesResponse, lat, long, isDeviceGpsEnabled,
          isPermissionAllowed) {
        placesNearbyResponse = nearbyPlacesResponse;
        if (lat != null && long != null) {
          emit(state.copyWith(
            userCurrentLocationLatLongWkb:
                WKBUtil.getWkbString(lat: lat, long: long),
          ));
        }
      },
    );
    emit(state.copyWith(placesNearbyResponse: placesNearbyResponse));
  }

  FutureOr<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    try {
      titleController.text = titleController.text.trim();
      descriptionController.text = descriptionController.text.trim();
      String hashtagsArea =
          '${titleController.text} ${hashtagsController.text}';
      List<String> hashtags = [];
      if (TextPatternDetector.isDetected(hashtagsArea, hashTagRegExp))
        hashtags = TextPatternDetector.extractDetections(
          hashtagsArea,
          hashTagRegExp,
        );
      if (hashtags.length > 30) {
        SmartDialog.showToast('You can only add 30 hashtags');
        return;
      }
      if (titleController.text.isEmpty) {
        SmartDialog.showToast('Title is required');
        return;
      }

      SmartDialog.showLoading();
      final String? videoUrl = await FileUploadService.uploadFilesToSST(
        state.videoFile!,
        userUid: (await AuthUserDb.getLastLoggedUserUid())!,
        fileType: 'video-post',
      );
      final String? thumbnailUrl = await FileUploadService.uploadFilesToSST(
        state.thumbnailFile!,
        userUid: (await AuthUserDb.getLastLoggedUserUid())!,
        fileType: 'video-post-thumbnail',
      );
      CreateVideoPostResponse? response = await PostApi.createVideoPost(
        post: CreateVideoPostRequest(
          title: titleController.text,
          description: descriptionController.text,
          userUid: await AuthUserDb.getLastLoggedUserUid(),
          hashtags: hashtags.isEmpty
              ? null
              : hashtags.map((e) => e.replaceAll("#", '')).toList(),
          location: state.selectedAddress,
          postCreatorType: state.pageArgument?.postCreatorType.value,
          thumbnail: thumbnailUrl,
          videoUrl: videoUrl,
          addressLatLongWkb: state.selectedAddressLatLongWkb,
          creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
          taggedUserUids: state.taggedUsersUid,
          taggedCommunityUids: state.taggedCommunitiesUid,
        ),
      );
      SmartDialog.dismiss();
      SmartDialog.showToast('${response?.message}');
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast('Error: $e');
    }
  }

  FutureOr<void> _onPickVideo(
    PickVideoEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    await CustomAssetPicker.pickVideoFromGallery(
      onCompleted: (File file) {
        emit(state.copyWith(videoFile: file));
      },
    );
    emit(
      state.copyWith(
        thumbnailFile: await getThumbnailFile(videoFile: state.videoFile!),
      ),
    );
  }

  FutureOr<void> _onPickThumbnail(
    PickThumbnailEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    await showWhatsevrThumbnailSelectionPage(
      videoFile: state.videoFile!,
      onThumbnailSelected: (File thumbnailFile) {
        emit(state.copyWith(thumbnailFile: thumbnailFile));
      },
    );
  }

  Future<void> _onUpdatePostAddress(
      UpdatePostAddressEvent event, Emitter<CreateVideoPostState> emit) async {
    emit(
      state.copyWith(
        selectedAddress: event.address,
        selectedAddressLatLongWkb: WKBUtil.getWkbString(
            lat: event.addressLatitude, long: event.addressLongitude),
      ),
    );
  }

  FutureOr<void> _onUpdateTaggedUsersAndCommunities(
      UpdateTaggedUsersAndCommunitiesEvent event,
      Emitter<CreateVideoPostState> emit) {
    if (event.clearAll == true) {
      emit(state.copyWith(
        taggedUsersUid: [],
        taggedCommunitiesUid: [],
      ));
    } else {
      List<String> taggedUsersUid = [
        ...state.taggedUsersUid,
        ...?event.taggedUsersUid
      ];
      List<String> taggedCommunitiesUid = [
        ...state.taggedCommunitiesUid,
        ...?event.taggedCommunitiesUid
      ];
      taggedUsersUid = taggedUsersUid.toSet().toList();
      taggedCommunitiesUid = taggedCommunitiesUid.toSet().toList();
      emit(state.copyWith(
        taggedUsersUid: taggedUsersUid,
        taggedCommunitiesUid: taggedCommunitiesUid,
      ));
    }
  }
}
