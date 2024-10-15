import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:detectable_text_field/detector/text_pattern_detector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/external/models/places_nearby.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';

import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/media/aspect_ratio.dart';
import 'package:whatsevr_app/config/widgets/media/thumbnail_selection.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';

import '../../../../../config/api/requests_model/sanity_check_new_video_post.dart';
import '../../../../../config/services/long_running_task/controller.dart';
import '../../../../../config/services/long_running_task/task_models/posts.dart';
import '../../../../../config/widgets/media/meta_data.dart';
import '../views/page.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class UploadPdfBloc extends Bloc<UploadPdfPostEvent, UploadPdfState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  UploadPdfBloc() : super(const UploadPdfState()) {
    on<UploadPdfInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);
    on<PickPdfEvent>(_onPickPdf);
    on<PickThumbnailEvent>(_onPickThumbnail);
  }
  FutureOr<void> _onInitial(
    UploadPdfInitialEvent event,
    Emitter<UploadPdfState> emit,
  ) async {
    try {
      emit(state.copyWith(pageArgument: event.pageArgument));

      (double, double)? latLong = await LocationService.getCurrentGpsLatLong();
      emit(state.copyWith(
        userCurrentLocationLatLongWkb:
            WKBUtil.getWkbString(lat: latLong?.$1, long: latLong?.$2),
      ));
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<UploadPdfState> emit,
  ) async {
    try {
      titleController.text = titleController.text.trim();
      descriptionController.text = descriptionController.text.trim();

      if (titleController.text.isEmpty) {
        throw BusinessException('Title is required');
      }

      SmartDialog.showLoading();
      //Sanity check
      (String?, int?)? itm = await PostApi.sanityCheckNewVideoPost(
          request: SanityCheckNewVideoPostRequest(
              mediaMetaData: MediaMetaData(
                aspectRatio: state.pdfMetaData?.aspectRatio,
                durationSec: state.pdfMetaData?.durationInSec,
                sizeBytes: state.pdfMetaData?.sizeInBytes,
              ),
              postData: PostData(
                userUid: await AuthUserDb.getLastLoggedUserUid(),
                postCreatorType: state.pageArgument?.postCreatorType.value,
              )));
      if (itm?.$2 != 200) {
        throw BusinessException(itm!.$1!);
      }

      WhatsevrLongTaskController.startServiceWithTaskData(
          taskData: VideoPostTaskDataForLRT(
            videoFilePath: state.pdfFile!.path,
            thumbnailFilePath: state.thumbnailFile!.path,
            title: titleController.text,
            description: descriptionController.text,
            userUid: (await AuthUserDb.getLastLoggedUserUid())!,
            postCreatorType: state.pageArgument?.postCreatorType.value,
            creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
            videoDurationInSec: state.pdfMetaData?.durationInSec,
          ),
          onTaskAssignFail: () async {
            SmartDialog.showLoading();
            final String? videoUrl =
                await FileUploadService.uploadFilesToSupabase(
              state.pdfFile!,
              userUid: (await AuthUserDb.getLastLoggedUserUid())!,
              fileRelatedTo: 'video-post',
            );
            final String? thumbnailUrl =
                await FileUploadService.uploadFilesToSupabase(
              state.thumbnailFile!,
              userUid: (await AuthUserDb.getLastLoggedUserUid())!,
              fileRelatedTo: 'video-post-thumbnail',
            );
            (String? message, int? statusCode)? response =
                await PostApi.createVideoPost(
              post: CreateVideoPostRequest(
                title: titleController.text,
                description: descriptionController.text,
                userUid: await AuthUserDb.getLastLoggedUserUid(),
                postCreatorType: state.pageArgument?.postCreatorType.value,
                thumbnail: thumbnailUrl,
                videoUrl: videoUrl,
                creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
                videoDurationInSec: state.pdfMetaData?.durationInSec,
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
          });
    } catch (e, stackTrace) {
      highLevelCatch(e, stackTrace);
    }
  }

  FutureOr<void> _onPickPdf(
    PickPdfEvent event,
    Emitter<UploadPdfState> emit,
  ) async {
    try {
      if (event.pickPdfFile == null) return;
      SmartDialog.showLoading(msg: 'Validating pdf...');
      FileMetaData? videoMetaData =
          await FileMetaData.fromFile(event.pickPdfFile);
      // Validate video metadata
      if (videoMetaData == null ||
          videoMetaData.isVideo != true ||
          videoMetaData.aspectRatio?.isAspectRatioLandscapeOrSquare != true) {
        throw BusinessException(
            'Video is not valid, it must be landscape or square');
      }

      emit(state.copyWith(pdfFile: event.pickPdfFile));

      final File? thumbnailFile =
          await getThumbnailFile(videoFile: event.pickPdfFile!);

      final FileMetaData? thumbnailMetaData =
          await FileMetaData.fromFile(thumbnailFile);

      emit(
        state.copyWith(
          thumbnailFile: thumbnailFile,
          pdfMetaData: videoMetaData,
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
    Emitter<UploadPdfState> emit,
  ) async {
    try {
      // Check if videoFile is null, return early if it is
      if (state.pdfFile == null) {
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
}
