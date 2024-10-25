import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBlocX extends Bloc<CommunityEventX, CommunityStateX> {
  CommunityBlocX() : super(AccountInitial()) {
    on<CommunityEventX>((CommunityEventX event, Emitter<CommunityStateX> emit) {
      // TODO: implement event handler
    });
  }
}
