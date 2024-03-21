import 'package:equatable/equatable.dart';

sealed class BlocSideEffect extends Equatable {}

class BlocSideEffectShowLoader extends BlocSideEffect {
  BlocSideEffectShowLoader({this.message});

  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}

class BlocSideEffectHideLoader extends BlocSideEffect {
  BlocSideEffectHideLoader();

  @override
  List<Object?> get props => <Object?>[];
}

class BlocSideEffectShowSnackbar extends BlocSideEffect {
  BlocSideEffectShowSnackbar({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

class BlocSideEffectShowToast extends BlocSideEffect {
  BlocSideEffectShowToast({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
