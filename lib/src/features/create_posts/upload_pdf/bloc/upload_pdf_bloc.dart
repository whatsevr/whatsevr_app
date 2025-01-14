import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/methods/posts.dart';
import 'package:whatsevr_app/config/api/requests_model/upload_pdf.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/services/location.dart';
import 'package:whatsevr_app/config/widgets/media/meta_data.dart';
import 'package:whatsevr_app/utils/geopoint_wkb_parser.dart';
import 'package:whatsevr_app/src/features/create_posts/upload_pdf/views/page.dart';

part 'upload_pdf_event.dart';
part 'upload_pdf_state.dart';

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
      emit(
        state.copyWith(
          userCurrentLocationLatLongWkb:
              WKBUtil.getWkbString(lat: latLong?.$1, long: latLong?.$2),
        ),
      );
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
      if (descriptionController.text.isEmpty) {
        throw BusinessException('Description is required');
      }
      if (state.pdfFile == null) {
        throw BusinessException('Please select a pdf file');
      }
      if (state.thumbnailFile == null) {
        throw BusinessException('Please select a thumbnail');
      }
      SmartDialog.showLoading(msg: 'Uploading pdf...');
      final String? pdfUrl = await FileUploadService.uploadFilesToSupabase(
        state.pdfFile!,
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
        fileRelatedTo: 'pdf-doc',
      );
      final String? thumbnailUrl =
          await FileUploadService.uploadFilesToSupabase(
        state.thumbnailFile!,
        userUid: (AuthUserDb.getLastLoggedUserUid())!,
        fileRelatedTo: 'pdf-doc-thumbnail',
      );
      final response = await PostApi.uploadPdfDoc(
        post: UploadPdfRequest(
          title: titleController.text,
          description: descriptionController.text,
          userUid: AuthUserDb.getLastLoggedUserUid(),
          postCreatorType: state.pageArgument?.postCreatorType.value,
          thumbnailUrl: thumbnailUrl,
          fileUrl: pdfUrl,
          creatorLatLongWkb: state.userCurrentLocationLatLongWkb,
        ),
      );
      if (response?.$1 == 200) {
        SmartDialog.dismiss();
        SmartDialog.showToast('${response?.$2}');
        AppNavigationService.goBack();
      }
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
      final int? sizeInBytes = event.pickPdfFile?.lengthSync();

      if ((sizeInBytes ?? 0) > 26214400) {
        throw BusinessException('Please select a pdf file less than 25 MB');
      }

      emit(
        UploadPdfState(
          pdfFile: event.pickPdfFile,
          pageArgument: state.pageArgument,
          userCurrentLocationLatLongWkb: state.userCurrentLocationLatLongWkb,
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
      if (state.pdfFile == null) {
        throw BusinessException('Please select a pdf first');
      }

      if (event.pickedThumbnailFile == null) {
        throw BusinessException('No thumbnail selected');
      }

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
