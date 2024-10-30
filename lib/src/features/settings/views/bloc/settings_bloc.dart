import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../config/api/external/models/business_validation_exception.dart';
import '../../../../../config/api/methods/community.dart';
import '../../../../../config/api/response_model/community/user_communities.dart';
import '../../../../../config/services/auth_db.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<InitialEvent>(_onInitialEvent);
    on<LoadUserCommunitiesEvent>(_onLoadUserCommunitiesEvent);
  }

  FutureOr<void> _onInitialEvent(
      InitialEvent event, Emitter<SettingsState> emit,) async {
    try {
      add(LoadUserCommunitiesEvent());
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }

  FutureOr<void> _onLoadUserCommunitiesEvent(
      LoadUserCommunitiesEvent event, Emitter<SettingsState> emit,) async {
    try {
      final UserCommunitiesResponse? userCommunitiesResponse =
          await CommunityApi.getUserCommunities(
              userUid: (AuthUserDb.getLastLoggedUserUid())!,);

      emit(state.copyWith(userCommunitiesResponse: userCommunitiesResponse));
    } catch (e, s) {
      highLevelCatch(e, s);
    }
  }
}
