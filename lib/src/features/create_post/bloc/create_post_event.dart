part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();
}

class CreatePostInitialEvent extends CreatePostEvent {
  const CreatePostInitialEvent();

  @override
  List<Object?> get props => [];
}
