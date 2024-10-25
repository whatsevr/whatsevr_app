part of 'community_bloc.dart';

sealed class CommunityStateX extends Equatable {
  const CommunityStateX();
}

final class AccountInitial extends CommunityStateX {
  @override
  List<Object> get props => <Object>[];
}
