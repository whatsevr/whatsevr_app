import 'package:hive/hive.dart';
import 'package:whatsevr_app/config/api/methods/user_relations.dart';
import 'package:whatsevr_app/config/api/response_model/user_relations/user_relations.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

class FollowUnfollowMiddleware {
  static String? _followedUsersBox;
  static const String _totalPagesKey = 'totalPages';
  static const int _pageSize = 500;
  static Set<String> followedUserUids = {};

  // Lazy initialization for Hive Box
  static Future<Box?> _getBox() async {
    final String? userUid = AuthUserDb.getLastLoggedUserUid();
    if (userUid == null) return null;
    _followedUsersBox = 'followedUsersBox_$userUid';
    if (!Hive.isBoxOpen(_followedUsersBox!)) {
      await Hive.openBox(_followedUsersBox!);
    }
    return Hive.box(_followedUsersBox!);
  }

  // Fetch and cache all followed user UIDs (One-time on app launch)
  static Future<void> fetchAndCacheAllFollowedUsers() async {
    followedUserUids.clear();
    final box = await _getBox();
    if (box == null) return;
    await _loadCachedFollowedUsers(); // Load from cache first

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

    followedUserUids = Set.from(allFollowedUids); // Update in-memory set
    await box.put(_totalPagesKey, page - 1); // Store total pages count
  }

  // Load cached followed users on app restart
  static Future<void> _loadCachedFollowedUsers() async {
    final box = await _getBox();
    if (box == null) return;
    final int totalPages = box.get(_totalPagesKey, defaultValue: 0);
    final List<String> allFollowedUids = [];

    for (int page = 1; page <= totalPages; page++) {
      final List<dynamic>? pageData = box.get('$_followedUsersBox$page');
      if (pageData != null) {
        allFollowedUids.addAll(pageData.cast<String>());
      }
    }

    followedUserUids = Set.from(allFollowedUids); // Update in-memory
  }

  // Fetch followed users from the API (with error handling)
  static Future<List<String>> _fetchFollowedUsersFromApi(int page) async {
    try {
      final UsersRelationResponse? response =
          await UserRelationsApi.getAllFollowing(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        page: page,
        pageSize: _pageSize,
      );
      List<String?> uids =
          response?.data?.map((e) => e.user?.uid).toList() ?? [];
      uids = uids.toSet().toList();
      return uids.whereType<String>().toList();
    } catch (e) {
      print('Error fetching followed users from API: $e');
      return [];
    }
  }

  // Toggle follow/unfollow for a user and persist the change
  static Future<void> toggleFollow(String userUid) async {
    final box = await _getBox();
    if (box == null) return;
    if (followedUserUids.contains(userUid)) {
      followedUserUids.remove(userUid);
      await _handleUnfollow(userUid);
    } else {
      followedUserUids.add(userUid);
      await _handleFollow(userUid);
    }

    // Persist updated followed users without re-fetching
    await _persistFollowedUsers(box);
  }

  // Helper method for handling follow API call
  static Future<void> _handleFollow(String userUid) async {
    try {
      await UserRelationsApi.followUser(
        followerUserUid: AuthUserDb.getLastLoggedUserUid()!,
        followeeUserUid: userUid,
      );
    } catch (e) {
      print('Error following user: $e');
    }
  }

  // Helper method for handling unfollow API call
  static Future<void> _handleUnfollow(String userUid) async {
    try {
      await UserRelationsApi.unfollowUser(
        followerUserUid: AuthUserDb.getLastLoggedUserUid()!,
        followeeUserUid: userUid,
      );
    } catch (e) {
      print('Error unfollowing user: $e');
    }
  }

  // Check if a user is followed
  static bool isFollowed(String? userUid) {
    if (userUid == null) return false;
    return followedUserUids.contains(userUid);
  }

  // Persist the followed users list to cache (batch updates)
  static Future<void> _persistFollowedUsers(Box? box) async {
    if (box == null) return;
    try {
      await box.put('followedUserUids', followedUserUids.toList());
    } catch (e) {
      print('Error persisting followed users to cache: $e');
    }
  }
}
