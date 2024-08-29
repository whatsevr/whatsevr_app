part of 'community_bloc.dart';

sealed class CommunityState extends Equatable {
  const CommunityState();
}

final class AccountInitial extends CommunityState {
  @override
  List<Object> get props => <Object>[];
}
