part of 'create_post_bloc.dart';

class UploadPdfState extends Equatable {
  final UploadPdfPageArgument? pageArgument;
  final File? pdfFile;
  final FileMetaData? pdfMetaData;
  final File? thumbnailFile;
  final FileMetaData? thumbnailMetaData;

  final String? userCurrentLocationLatLongWkb;

  const UploadPdfState({
    this.pageArgument,
    this.pdfFile,
    this.pdfMetaData,
    this.thumbnailFile,
    this.thumbnailMetaData,
    this.userCurrentLocationLatLongWkb,
  });

  @override
  List<Object?> get props => <Object?>[
        pdfFile,
        pdfMetaData,
        thumbnailFile,
        thumbnailMetaData,
        pageArgument,
        userCurrentLocationLatLongWkb,
      ];

  UploadPdfState copyWith({
    UploadPdfPageArgument? pageArgument,
    File? pdfFile,
    FileMetaData? pdfMetaData,
    File? thumbnailFile,
    FileMetaData? thumbnailMetaData,
    String? userCurrentLocationLatLongWkb,
  }) {
    return UploadPdfState(
      pageArgument: pageArgument ?? this.pageArgument,
      pdfFile: pdfFile ?? this.pdfFile,
      pdfMetaData: pdfMetaData ?? this.pdfMetaData,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      thumbnailMetaData: thumbnailMetaData ?? this.thumbnailMetaData,
      userCurrentLocationLatLongWkb:
          userCurrentLocationLatLongWkb ?? this.userCurrentLocationLatLongWkb,
    );
  }
}
