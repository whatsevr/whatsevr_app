part of 'upload_pdf_bloc.dart';

class UploadPdfState extends Equatable {
  final UploadPdfPageArgument? pageArgument;
  final File? pdfFile;

  final File? thumbnailFile;
  final FileMetaData? thumbnailMetaData;

  final String? userCurrentLocationLatLongWkb;

  const UploadPdfState({
    this.pageArgument,
    this.pdfFile,
    this.thumbnailFile,
    this.thumbnailMetaData,
    this.userCurrentLocationLatLongWkb,
  });

  @override
  List<Object?> get props => <Object?>[
        pdfFile,
        thumbnailFile,
        thumbnailMetaData,
        pageArgument,
        userCurrentLocationLatLongWkb,
      ];

  UploadPdfState copyWith({
    UploadPdfPageArgument? pageArgument,
    File? pdfFile,
    File? thumbnailFile,
    FileMetaData? thumbnailMetaData,
    String? userCurrentLocationLatLongWkb,
  }) {
    return UploadPdfState(
      pageArgument: pageArgument ?? this.pageArgument,
      pdfFile: pdfFile ?? this.pdfFile,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      thumbnailMetaData: thumbnailMetaData ?? this.thumbnailMetaData,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
    );
  }
}
