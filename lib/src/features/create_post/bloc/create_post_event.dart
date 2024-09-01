part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();
}

class CreatePostInitialEvent extends CreatePostEvent {
  const CreatePostInitialEvent();

  @override
  List<Object?> get props => [];
}

class SubmitPostEvent extends CreatePostEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => [];
}

class PickVideoEvent extends CreatePostEvent {
  const PickVideoEvent();

  @override
  List<Object?> get props => [];
}

class PickThumbnailEvent extends CreatePostEvent {
  const PickThumbnailEvent();

  @override
  List<Object?> get props => [];
}
