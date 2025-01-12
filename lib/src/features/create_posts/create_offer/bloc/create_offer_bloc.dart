import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/detector/text_pattern_detector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/create_offer.dart';
import 'package:whatsevr_app/config/api/requests_model/sanity_check_new_offer.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/meta_data.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';
import 'package:whatsevr_app/src/features/create_posts/create_offer/views/page.dart';

part 'create_offer_event.dart';
part 'create_offer_state.dart';

class CreateOfferBloc extends Bloc<CreateOfferEvent, CreateOfferState> {
  final int maxVideoCount = 2;
  final int maxImageCount = 5;
  List<String> targetGender = ['All', 'Man', 'Women'];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController ctaActionUrlController = TextEditingController();

  CreateOfferBloc() : super(const CreateOfferState()) {
    on<CreateOfferInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);
    on<PickVideoEvent>(_onPickVideo);
    on<ChangeVideoThumbnail>(_onChangeVideoThumbnail);
    on<PickImageEvent>(_onPickImage);

    on<UpdateTaggedUsersAndCommunitiesEvent>(
      _onUpdateTaggedUsersAndCommunities,
    );
    on<RemoveVideoOrImageEvent>(_onRemoveVideoOrImage);
    on<AddOrRemoveTargetAddressEvent>(_onAddOrRemoveTargetAddress);
    on<UpdateCtaActionEvent>(_onUpdateCtaAction);
    on<UpdateTargetGenderEvent>(_onUpdateTargetGender);
  }
  FutureOr<void> _onInitial(
    CreateOfferInitialEvent event,
    Emitter<CreateOfferState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          communityUid: event.pageArgument.communityUid,
          postCreatorType: event.pageArgument.postCreatorType,
        ),
      );

      (double, double)? currentGpsLatLong =
          await LocationService.getCurrentGpsLatLong();
      if (currentGpsLatLong != null) {
        emit(
          state.copyWith(
            userCurrentLocationLatLongWkb: WKBUtil.getWkbString(
              lat: currentGpsLatLong.$1,
              long: currentGpsLatLong.$2,
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<CreateOfferState> emit,
  ) async {
    try {
      titleController.text = titleController.text.trim();
      if (titleController.text.isEmpty) {
        throw BusinessException('Caption is required');
      }
      if (titleController.text.isEmpty) {
        throw BusinessException('Description is required');
      }
      if (statusController.text.isEmpty) {
        throw BusinessException('Status is required');
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
      (String?, int?)? itm = await PostApi.sanityCheckNewOffer(
        request: SanityCheckNewOfferRequest(
          mediaMetaData: [
            for (var e in state.uiFilesData)
              if (e.type == UiFileTypes.video)
                MediaMetaDatum(
                  videoDurationSec: e.fileMetaData?.durationInSec,
                  sizeBytes: e.fileMetaData?.sizeInBytes,
                ),
          ],
          postData: PostData(
            userUid: AuthUserDb.getLastLoggedUserUid(),
            postCreatorType: state.postCreatorType?.value,
            communityUid: state.communityUid,
          ),
        ),
      );
      if (itm?.$2 != 200) {
        throw BusinessException(itm!.$1!);
      }
      SmartDialog.showLoading(msg: 'Creating post...');
      final response = await PostApi.createOffer(
        post: CreateOfferRequest(
          title: titleController.text,
          description: descriptionController.text,
          status: statusController.text,
          userUid: AuthUserDb.getLastLoggedUserUid(),
          targetAreas: state.selectedTargetAddresses,
          targetGender: state.selectedTargetGender?.toLowerCase(),
          hashtags: hashtags,
          postCreatorType: state.postCreatorType?.value,
          creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
          taggedUserUids: state.taggedUsersUid,
          taggedCommunityUids: state.taggedCommunitiesUid,
          filesData: [
            for (var e in state.uiFilesData)
              e.type == UiFileTypes.video
                  ? VideoFileDatum(
                      type: 'video',
                      videoUrl: await FileUploadService.uploadFilesToSupabase(
                        e.file!,
                        userUid: (AuthUserDb.getLastLoggedUserUid())!,
                        fileRelatedTo: 'offer-video',
                      ),
                      videoThumbnailUrl:
                          await FileUploadService.uploadFilesToSupabase(
                        e.thumbnailFile!,
                        userUid: (AuthUserDb.getLastLoggedUserUid())!,
                        fileRelatedTo: 'offer-thumbnail',
                      ),
                      videoDurationMs: e.fileMetaData?.durationInMs,
                    )
                  : ImageFileDatum(
                      type: 'image',
                      imageUrl: await FileUploadService.uploadFilesToSupabase(
                        e.file!,
                        userUid: (AuthUserDb.getLastLoggedUserUid())!,
                        fileRelatedTo: 'offer-image',
                      ),
                    ),
          ],
          ctaAction:
              ctaActionUrlController.text.isEmpty ? null : state.ctaAction,
          ctaActionUrl: state.ctaAction?.isNotEmpty ?? false
              ? ctaActionUrlController.text
              : null,
          communityUid: state.communityUid,
        ),
      );

      if (response != null) {
        SmartDialog.dismiss();
        SmartDialog.showToast('${response.$2}');
        AppNavigationService.goBack();
      }
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onPickVideo(
    PickVideoEvent event,
    Emitter<CreateOfferState> emit,
  ) async {
    try {
      final int videoCount = state.uiFilesData
          .where((element) => element.type == UiFileTypes.video)
          .length;
      if (videoCount >= maxVideoCount) {
        throw BusinessException('You can only select $maxVideoCount videos');
      }

      final FileMetaData? videoMetaData =
          await FileMetaData.fromFile(event.pickedVideoFile);
      if (videoMetaData == null ||
          videoMetaData.isVideo != true ||
          videoMetaData.aspectRatio?.isAspectRatioLandscapeOrSquare != true) {
        throw BusinessException(
          'Video is not valid, it must be landscape or square',
        );
      }
      final File? thumbnailFile =
          await getThumbnailFile(videoFile: event.pickedVideoFile!);

      final FileMetaData? thumbnailMetaData =
          await FileMetaData.fromFile(thumbnailFile);
      if (thumbnailMetaData == null ||
          thumbnailMetaData.isImage != true ||
          thumbnailMetaData.aspectRatio?.isAspectRatioLandscapeOrSquare !=
              true) {
        throw BusinessException(
          'Thumbnail is not valid, it must be landscape or square',
        );
      }
      emit(
        state.copyWith(
          uiFilesData: [
            ...state.uiFilesData,
            UiFileData(
              file: event.pickedVideoFile,
              type: UiFileTypes.video,
              fileMetaData: videoMetaData,
              thumbnailFile: thumbnailFile,
              thumbnailMetaData: thumbnailMetaData,
            ),
          ],
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  Future<void> _onChangeVideoThumbnail(
    ChangeVideoThumbnail event,
    Emitter<CreateOfferState> emit,
  ) async {
    try {
      final FileMetaData? thumbnailMetaData =
          await FileMetaData.fromFile(event.pickedThumbnailFile);
      if (thumbnailMetaData == null ||
          thumbnailMetaData.isImage != true ||
          thumbnailMetaData.aspectRatio?.isAspectRatioLandscapeOrSquare !=
              true) {
        throw BusinessException(
          'Thumbnail is not valid, it must be landscape or square',
        );
      }
      emit(
        state.copyWith(
          uiFilesData: state.uiFilesData
              .map(
                (e) => e == event.uiFileData
                    ? e.copyWith(
                        thumbnailFile: event.pickedThumbnailFile,
                        thumbnailMetaData: thumbnailMetaData,
                      )
                    : e,
              )
              .toList(),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onUpdateTaggedUsersAndCommunities(
    UpdateTaggedUsersAndCommunitiesEvent event,
    Emitter<CreateOfferState> emit,
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
    Emitter<CreateOfferState> emit,
  ) async {
    try {
      final FileMetaData? imageMetaData =
          await FileMetaData.fromFile(event.pickedImageFile);
      if (imageMetaData == null ||
          imageMetaData.isImage != true ||
          imageMetaData.aspectRatio?.isAspectRatioLandscapeOrSquare != true) {
        throw BusinessException(
          'Image is not valid, it must be landscape or square',
        );
      }
      emit(
        state.copyWith(
          uiFilesData: [
            ...state.uiFilesData,
            UiFileData(
              file: event.pickedImageFile,
              type: UiFileTypes.image,
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
    Emitter<CreateOfferState> emit,
  ) {
    try {
      emit(
        state.copyWith(
          uiFilesData: state.uiFilesData
              .where((element) => element != event.uiFileData)
              .toList(),
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onAddOrRemoveTargetAddress(
    AddOrRemoveTargetAddressEvent event,
    Emitter<CreateOfferState> emit,
  ) async {
    try {
      if (event.removableTargetAddress != null) {
        emit(
          state.copyWith(
            selectedTargetAddresses: state.selectedTargetAddresses!
                .where((element) => element != event.removableTargetAddress)
                .toList(),
          ),
        );
        return;
      }
      if (event.countryName == null &&
          event.stateName == null &&
          event.cityName == null) {
        return;
      }
      String address = '';
      if (event.countryName?.isNotEmpty ?? false) {
        address += '${event.countryName}';
      }
      if (event.stateName?.isNotEmpty ?? false) {
        address += ', ${event.stateName}';
      }
      if (event.cityName?.isNotEmpty ?? false) {
        address += ', ${event.cityName}';
      }
      emit(
        state.copyWith(
          selectedTargetAddresses: state.selectedTargetAddresses! + [address],
        ),
      );
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onUpdateCtaAction(
    UpdateCtaActionEvent event,
    Emitter<CreateOfferState> emit,
  ) {
    try {
      emit(state.copyWith(ctaAction: event.ctaAction));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onUpdateTargetGender(
    UpdateTargetGenderEvent event,
    Emitter<CreateOfferState> emit,
  ) {
    try {
      emit(state.copyWith(selectedTargetGender: event.targetGender));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }
}
