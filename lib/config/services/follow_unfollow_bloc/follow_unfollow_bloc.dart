import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:whatsevr_app/config/api/methods/user_relations.dart';
import 'package:whatsevr_app/config/api/response_model/user_relations/user_relations.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

part 'follow_unfollow_event.dart';
part 'follow_unfollow_state.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  static const String _totalPagesKey = 'totalPages';
  static const int _pageSize = 500;
  static String? _followedUsersBox;

  FollowUnfollowBloc() : super(const FollowUnfollowState(followedUserIds: {})) {
    on<FetchFollowedUsers>(_onFetchFollowedUsers);
    on<ToggleFollow>(_onToggleFollow);
    on<ReloadFollowedUsers>(_onReloadFollowedUsers);
  }

  // Lazy initialization for Hive Box
  Future<Box?> _getBox() async {
    final String? userUid = AuthUserDb.getLastLoggedUserUid();
    if (userUid == null) return null;
    _followedUsersBox = 'followedUsersBox_$userUid';
    if (!Hive.isBoxOpen(_followedUsersBox!)) {
      await Hive.openBox(_followedUsersBox!);
    }
    return Hive.box(_followedUsersBox!);
  }

  // Fetch and cache all followed user UIDs (One-time on app launch)
  Future<void> _onFetchFollowedUsers(
      FetchFollowedUsers event, Emitter<FollowUnfollowState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, followedUserIds: {}));

    try {
      final box = await _getBox();
      if (box == null) {
        emit(state.copyWith(isLoading: false, error: 'User not logged in'));
        return;
      }

      await _loadCachedFollowedUsers(box); // Load from cache first
      int page = 1;
      final List<String> allFollowedUids = [];

      while (true) {
        final List<String> currentPageUids =
            await _fetchFollowedUsersFromApi(page);
        if (currentPageUids.isEmpty) break;

        allFollowedUids.addAll(currentPageUids);
        await box.put(
            '$_followedUsersBox$page', currentPageUids); // Cache by page
        page++;
      }

      emit(state.copyWith(
        followedUserIds: Set.from(allFollowedUids),
        isLoading: false,
      ));

      await box.put(_totalPagesKey, page - 1); // Store total pages count
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: 'Failed to fetch followed users'));
    }
  }

  // Reload cached followed users on app restart
  Future<void> _onReloadFollowedUsers(
      ReloadFollowedUsers event, Emitter<FollowUnfollowState> emit) async {
    final box = await _getBox();
    if (box == null) return;

    try {
      await _loadCachedFollowedUsers(box);
      emit(state.copyWith(
          followedUserIds: state.followedUserIds, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to reload followed users'));
    }
  }

  // Load cached followed users from Hive
  Future<void> _loadCachedFollowedUsers(Box box) async {
    final int totalPages = box.get(_totalPagesKey, defaultValue: 0);
    final List<String> allFollowedUids = [];

    for (int page = 1; page <= totalPages; page++) {
      final List<dynamic>? pageData = box.get('$_followedUsersBox$page');
      if (pageData != null) {
        allFollowedUids.addAll(pageData.cast<String>());
      }
    }

    emit(state.copyWith(followedUserIds: Set.from(allFollowedUids)));
  }

  // Fetch followed users from API (with error handling)
  Future<List<String>> _fetchFollowedUsersFromApi(int page) async {
    try {
      final UsersRelationResponse? response =
          await UserRelationsApi.getAllFollowing(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        page: page,
        pageSize: _pageSize,
      );
      List<String?> uids =
          response?.data?.map((e) => e.user?.uid).toList() ?? [];
      return uids.whereType<String>().toSet().toList();
    } catch (e) {
      print('Error fetching followed users from API: $e');
      return [];
    }
  }

  // Toggle follow/unfollow for a user and persist the change
  Future<void> _onToggleFollow(
      ToggleFollow event, Emitter<FollowUnfollowState> emit) async {
    final box = await _getBox();
    if (box == null) return;

    try {
      final isCurrentlyFollowed = state.followedUserIds.contains(event.userUid);
      final updatedFollowedUserIds = Set<String>.from(state.followedUserIds);

      if (isCurrentlyFollowed) {
        updatedFollowedUserIds.remove(event.userUid);
        await _handleUnfollow(event.userUid);
      } else {
        updatedFollowedUserIds.add(event.userUid);
        await _handleFollow(event.userUid);
      }

      emit(state.copyWith(followedUserIds: updatedFollowedUserIds));
      await _persistFollowedUsers(box, updatedFollowedUserIds);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to toggle follow'));
    }
  }

  // Helper methods to handle follow/unfollow API calls
  Future<void> _handleFollow(String userUid) async {
    try {
      await UserRelationsApi.followUser(
        followerUserUid: AuthUserDb.getLastLoggedUserUid()!,
        followeeUserUid: userUid,
      );
    } catch (e) {
      print('Error following user: $e');
    }
  }

  Future<void> _handleUnfollow(String userUid) async {
    try {
      await UserRelationsApi.unfollowUser(
        followerUserUid: AuthUserDb.getLastLoggedUserUid()!,
        followeeUserUid: userUid,
      );
    } catch (e) {
      print('Error unfollowing user: $e');
    }
  }

  // Persist the followed users list to cache
  Future<void> _persistFollowedUsers(
      Box? box, Set<String> followedUserIds) async {
    if (box == null) return;
    try {
      await box.put('followedUserIds', followedUserIds.toList());
    } catch (e) {
      print('Error persisting followed users to cache: $e');
    }
  }
}
