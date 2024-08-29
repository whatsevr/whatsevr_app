import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(AccountInitial()) {
    on<CommunityEvent>((CommunityEvent event, Emitter<CommunityState> emit) {
      // TODO: implement event handler
    });
  }
}
