part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();
}

class InitialEvent extends SplashEvent {
  const InitialEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginOrSignupEvent extends SplashEvent {
  const LoginOrSignupEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class CheckUserStatus extends SplashEvent {
  final String? userUid;
  const CheckUserStatus({this.userUid});

  @override
  List<Object?> get props => <Object?>[userUid];
}
