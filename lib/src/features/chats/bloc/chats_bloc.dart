import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsEvent>((ChatsEvent event, Emitter<ChatsState> emit) {
      // TODO: implement event handler
    });
  }
}
