part of 'create_post_bloc.dart';

class CreatePostState extends Equatable {
  final File? videoFile;
  final File? thumbnailFile;
  const CreatePostState({this.videoFile, this.thumbnailFile});

  @override
  List<Object?> get props => <Object?>[videoFile, thumbnailFile];

  CreatePostState copyWith({
    File? videoFile,
    File? thumbnailFile,
  }) {
    return CreatePostState(
      videoFile: videoFile ?? this.videoFile,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
    );
  }
}
