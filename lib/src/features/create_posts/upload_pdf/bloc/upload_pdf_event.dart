part of 'upload_pdf_bloc.dart';

sealed class UploadPdfPostEvent extends Equatable {
  const UploadPdfPostEvent();
}

class UploadPdfInitialEvent extends UploadPdfPostEvent {
  final UploadPdfPageArgument pageArgument;
  const UploadPdfInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[];
}

class SubmitPostEvent extends UploadPdfPostEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickPdfEvent extends UploadPdfPostEvent {
  final File? pickPdfFile;
  const PickPdfEvent({required this.pickPdfFile});

  @override
  List<Object?> get props => <Object?>[pickPdfFile];
}

class PickThumbnailEvent extends UploadPdfPostEvent {
  final File? pickedThumbnailFile;
  const PickThumbnailEvent({required this.pickedThumbnailFile});

  @override
  List<Object?> get props => <Object?>[pickedThumbnailFile];
}
