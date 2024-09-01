import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(CreatePostState()) {
    on<CreatePostInitialEvent>(_onInitial);
  }
  FutureOr<void> _onInitial(
      CreatePostInitialEvent event, Emitter<CreatePostState> emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.video,
    );
  }
}
