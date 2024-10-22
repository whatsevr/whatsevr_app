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

class ContinueToLoginOrRegisterEvent extends SplashEvent {
  final dynamic authUserData;
  const ContinueToLoginOrRegisterEvent({this.authUserData});

  @override
  List<Object?> get props => <Object?>[authUserData];
}
