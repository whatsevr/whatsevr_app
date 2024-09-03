import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/response_model/create_video_post.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';

import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/create_video_post.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController hashtagsController = TextEditingController();

  CreatePostBloc() : super(CreatePostState()) {
    on<CreatePostInitialEvent>(_onInitial);
    on<SubmitPostEvent>(_onSubmit);
    on<PickVideoEvent>(_onPickVideo);
    on<PickThumbnailEvent>(_onPickThumbnail);
  }
  FutureOr<void> _onInitial(
    CreatePostInitialEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.video,
    );

    emit(state.copyWith(videoFile: File(result!.files.single.path!)));
  }

  FutureOr<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<CreatePostState> emit,
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
          userUid: 'MO-2a58e344d0b9463686c486ad99929666',
          hashtags: <String>['hashtag1', 'hashtag2'],
          location: 'Location',
          postCreatorType: 'account',
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
    Emitter<CreatePostState> emit,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    emit(state.copyWith(videoFile: File(result!.files.single.path!)));
  }

  FutureOr<void> _onPickThumbnail(
    PickThumbnailEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    emit(state.copyWith(thumbnailFile: File(result!.files.single.path!)));
  }
}
