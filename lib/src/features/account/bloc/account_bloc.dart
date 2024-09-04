import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountState()) {
    on<AccountInitialEvent>(_onInitial);
  }

  FutureOr<void> _onInitial(
      AccountInitialEvent event, Emitter<AccountState> emit) async {
    try {
      String? userUid = await AuthUserDb.getLastLoggedUserUid();
      if (userUid == null) return;
      ProfileDetailsResponse? profileDetailsResponse =
          await UsersApi.getProfileDetails(userUid: userUid);
      emit(state.copyWith(
        profileDetailsResponse: profileDetailsResponse,
      ));
    } catch (e) {
      SmartDialog.showToast('$e');
    }
  }
}
