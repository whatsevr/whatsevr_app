import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/response_model/create_video_post.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/views/page.dart';

import '../../../../../utils/video.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreateVideoPostBloc
    extends Bloc<CreateVideoPostEvent, CreateVideoPostState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController hashtagsController = TextEditingController();

  CreateVideoPostBloc() : super(CreateVideoPostState()) {
    on<CreatePostInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);
    on<PickVideoEvent>(_onPickVideo);
    on<PickThumbnailEvent>(_onPickThumbnail);
  }
  FutureOr<void> _onInitial(
    CreatePostInitialEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    emit(state.copyWith(pageArgument: event.pageArgument));
    add(PickVideoEvent());
  }

  FutureOr<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    try {
      titleController.text = titleController.text.trim();
      descriptionController.text = descriptionController.text.trim();
      locationController.text = locationController.text.trim();
      hashtagsController.text = hashtagsController.text.trim();

      if (titleController.text.isEmpty) {
        SmartDialog.showToast('Title is required');
        return;
      }

      SmartDialog.showLoading();
      final String? videoUrl =
          await FileUploadService.uploadFilesToSST(state.videoFile!);
      final String? thumbnailUrl =
          await FileUploadService.uploadFilesToSST(state.thumbnailFile!);
      CreateVideoPostResponse? response = await PostApi.createVideoPost(
        post: CreateVideoPostRequest(
          title: titleController.text,
          description: descriptionController.text,
          userUid: await AuthUserDb.getLastLoggedUserId(),
          hashtags: <String>['hashtag1', 'hashtag2'],
          location: 'Location',
          postCreatorType: state.pageArgument?.postCreatorType.value,
          thumbnail: thumbnailUrl,
          videoUrl: videoUrl,
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.video,
    );

    emit(state.copyWith(videoFile: File(result!.files.single.path!)));

    emit(state.copyWith(
        thumbnailFile: await getThumbnailFile(state.videoFile!)));
  }

  FutureOr<void> _onPickThumbnail(
    PickThumbnailEvent event,
    Emitter<CreateVideoPostState> emit,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    emit(state.copyWith(thumbnailFile: File(result!.files.single.path!)));
  }
}
