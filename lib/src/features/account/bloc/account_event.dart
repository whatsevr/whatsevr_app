part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccountInitialEvent extends AccountEvent {
  final AccountPageArgument? accountPageArgument;

  const AccountInitialEvent({required this.accountPageArgument});

  @override
  List<Object> get props => <Object>[];
}

class LoadAccountData extends AccountEvent {
  const LoadAccountData();

  @override
  List<Object> get props => <Object>[];
}
