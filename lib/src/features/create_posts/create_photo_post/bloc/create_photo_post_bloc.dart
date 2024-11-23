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
import 'package:whatsevr_app/config/api/requests_model/create_photo_post.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_photo_posts.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/media/meta_data.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';
import 'package:whatsevr_app/src/features/create_posts/create_photo_post/views/page.dart';

part 'create_photo_post_event.dart';
part 'create_photo_post_state.dart';

class CreatePhotoPostBloc
    extends Bloc<CreatePhotoPostEvent, CreatePhotoPostState> {
  final int maxImageCount = 10;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CreatePhotoPostBloc() : super(const CreatePhotoPostState()) {
    on<CreateOfferInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);

    on<UpdatePostAddressEvent>(_onUpdatePostAddress);

    on<PickImageEvent>(_onPickImage);

    on<UpdateTaggedUsersAndCommunitiesEvent>(
      _onUpdateTaggedUsersAndCommunities,
    );
    on<RemoveVideoOrImageEvent>(_onRemoveVideoOrImage);
  }
  FutureOr<void> _onInitial(
    CreateOfferInitialEvent event,
    Emitter<CreatePhotoPostState> emit,
  ) async {
    try {
      emit(state.copyWith(pageArgument: event.pageArgument));

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

  Future<void> _onUpdatePostAddress(
    UpdatePostAddressEvent event,
    Emitter<CreatePhotoPostState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          selectedPostLocation: event.address,
          selectedPostLocationLatLongWkb: WKBUtil.getWkbString(
            lat: event.addressLatitude,
            long: event.addressLongitude,
          ),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<CreatePhotoPostState> emit,
  ) async {
    try {
      titleController.text = titleController.text.trim();
      if (titleController.text.isEmpty) {
        throw BusinessException('Caption is required');
      }
      if (titleController.text.isEmpty) {
        throw BusinessException('Description is required');
      }

      final String hashtagsArea =
          titleController.text + descriptionController.text;
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

      SmartDialog.showLoading(msg: 'Validating post...');
      //Sanity check
      (String?, int?)? itm = await PostApi.sanityCheckNewPhotoPost(
        request: SanityCheckNewPhotoPostRequest(
          mediaMetaData: [
            for (var e in state.uiImageData)
              MediaMetaDatum(
                imageSizeBytes: e.fileMetaData?.sizeInBytes,
              ),
          ],
          postData: PostData(
            userUid: AuthUserDb.getLastLoggedUserUid(),
            postCreatorType: state.pageArgument?.postCreatorType.value,
          ),
        ),
      );
      if (itm?.$2 != 200) {
        throw BusinessException(itm!.$1!);
      }
      SmartDialog.showLoading(msg: 'Creating post...');
      (String?, int?)? response = await PostApi.createPhotoPost(
        post: CreatePhotoPostRequest(
          title: titleController.text,
          description: descriptionController.text,
          userUid: AuthUserDb.getLastLoggedUserUid(),
          location: state.selectedPostLocation,
          addressLatLongWkb: state.selectedPostLocationLatLongWkb,
          hashtags: hashtags,
          postCreatorType: state.pageArgument?.postCreatorType.value,
          creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
          taggedUserUids: state.taggedUsersUid,
          taggedCommunityUids: state.taggedCommunitiesUid,
          filesData: [
            for (var e in state.uiImageData)
              FilesDatum(
                type: 'image',
                imageUrl: await FileUploadService.uploadFilesToSupabase(
                  e.file!,
                  userUid: (AuthUserDb.getLastLoggedUserUid())!,
                  fileRelatedTo: 'photo-post-image',
                ),
              ),
          ],
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

  FutureOr<void> _onUpdateTaggedUsersAndCommunities(
    UpdateTaggedUsersAndCommunitiesEvent event,
    Emitter<CreatePhotoPostState> emit,
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
    Emitter<CreatePhotoPostState> emit,
  ) async {
    try {
      final FileMetaData? imageMetaData =
          await FileMetaData.fromFile(event.pickedImageFile);
      if (imageMetaData == null || imageMetaData.isImage != true) {
        throw BusinessException('Image is not valid');
      }
      emit(
        state.copyWith(
          uiFilesData: [
            ...state.uiImageData,
            UiImageData(
              file: event.pickedImageFile,
              fileMetaData: imageMetaData,
            ),
          ],
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onRemoveVideoOrImage(
    RemoveVideoOrImageEvent event,
    Emitter<CreatePhotoPostState> emit,
  ) {
    try {
      emit(
        state.copyWith(
          uiFilesData: state.uiImageData
              .where((element) => element != event.uiFileData)
              .toList(),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }
}
