part of 'create_post_bloc.dart';

class CreateVideoPostState extends Equatable {
  final CreateVideoPostPageArgument? pageArgument;
  final File? videoFile;
  final File? thumbnailFile;
  const CreateVideoPostState(
      {this.pageArgument, this.videoFile, this.thumbnailFile,});

  @override
  List<Object?> get props => <Object?>[videoFile, thumbnailFile, pageArgument];

  CreateVideoPostState copyWith({
    CreateVideoPostPageArgument? pageArgument,
    File? videoFile,
    File? thumbnailFile,
  }) {
    return CreateVideoPostState(
      pageArgument: pageArgument ?? this.pageArgument,
      videoFile: videoFile ?? this.videoFile,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
    );
  }
}
