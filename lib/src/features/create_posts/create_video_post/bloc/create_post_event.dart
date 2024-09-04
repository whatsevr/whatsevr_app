part of 'create_post_bloc.dart';

sealed class CreateVideoPostEvent extends Equatable {
  const CreateVideoPostEvent();
}

class CreatePostInitialEvent extends CreateVideoPostEvent {
  final CreateVideoPostPageArgument pageArgument;
  const CreatePostInitialEvent({required this.pageArgument});

  @override
  List<Object?> get props => <Object?>[];
}

class SubmitPostEvent extends CreateVideoPostEvent {
  const SubmitPostEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickVideoEvent extends CreateVideoPostEvent {
  const PickVideoEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PickThumbnailEvent extends CreateVideoPostEvent {
  const PickThumbnailEvent();

  @override
  List<Object?> get props => <Object?>[];
}
