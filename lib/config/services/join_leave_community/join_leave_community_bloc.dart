import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/methods/user_relations.dart';
import 'package:whatsevr_app/config/api/response_model/community/user_communities.dart';
import 'package:whatsevr_app/config/api/response_model/user_relations/user_relations.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

part 'join_leave_community_event.dart';
part 'join_leave_community_state.dart';

class JoinLeaveCommunityBloc
    extends Bloc<JoinLeaveCommunityEvent, JoinLeaveCommunityState> {
  static const String _totalPagesKey = 'totalPages';
  static const int _pageSize = 500;
  static String? _userCommunitiesBox;

  JoinLeaveCommunityBloc() 
      : super(const JoinLeaveCommunityState(userCommunities: {})) {
    on<FetchUserCommunities>(_onFetchUserCommunities);
    on<JoinOrLeave>(_onJoinOrLeave);
    on<ReloadUserCommunities>(_onReloadUserCommunities);
  }

  Future<Box?> _getBox() async {
    final String? userUid = AuthUserDb.getLastLoggedUserUid();
    if (userUid == null) return null;
    _userCommunitiesBox = 'joinedCommunitiesBox_$userUid';
    if (!Hive.isBoxOpen(_userCommunitiesBox!)) {
      await Hive.openBox(_userCommunitiesBox!);
    }
    return Hive.box(_userCommunitiesBox!);
  }

  Future<void> _onFetchUserCommunities(
    FetchUserCommunities event,
    Emitter<JoinLeaveCommunityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, userCommunities: {}));

    try {
      final box = await _getBox();
      if (box == null) {
        emit(state.copyWith(isLoading: false, error: 'User not logged in'));
        return;
      }

      await _loadCachedUserCommunities(box); // Load from cache first
      int page = 1;
      final List<String> allUserCommunities = [];

      while (true) {
        final List<String> currentPageUids =
            await _fetchUserCommunitiesFromApi(page);
        if (currentPageUids.isEmpty) break;

        allUserCommunities.addAll(currentPageUids);
        await box.put(
          '$_userCommunitiesBox$page',
          currentPageUids,
        ); // Cache by page
        page++;
      }

      emit(
        state.copyWith(
          userCommunities: Set.from(allUserCommunities),
          isLoading: false,
        ),
      );

      await box.put(_totalPagesKey, page - 1); // Store total pages count
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to fetch joined communities',
        ),
      );
    }
  }

  Future<void> _onReloadUserCommunities(
    ReloadUserCommunities event,
    Emitter<JoinLeaveCommunityState> emit,
  ) async {
    final box = await _getBox();
    if (box == null) return;

    try {
      await _loadCachedUserCommunities(box);
      emit(
        state.copyWith(
          userCommunities: state.userCommunities,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Failed to reload followed users'));
    }
  }

  Future<void> _loadCachedUserCommunities(Box box) async {
    final int totalPages = box.get(_totalPagesKey, defaultValue: 0);
    final List<String> allFollowedUids = [];

    for (int page = 1; page <= totalPages; page++) {
      final List<dynamic>? pageData = box.get('$_userCommunitiesBox$page');
      if (pageData != null) {
        allFollowedUids.addAll(pageData.cast<String>());
      }
    }

    emit(state.copyWith(userCommunities: Set.from(allFollowedUids)));
  }

  Future<List<String>> _fetchUserCommunitiesFromApi(int page) async {
    try {
      final UserCommunitiesResponse? response =
          await CommunityApi.getUserCommunities(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        page: page,
        pageSize: _pageSize,
      );

      final List<String> communityUids = [];
      
      if (response?.userCommunities != null) {
        communityUids.addAll(
          response!.userCommunities!
              .map((e) => e.uid)
              .whereType<String>()
              .toList(),
        );
      }
      
      if (response?.joinedCommunities != null) {
        communityUids.addAll(
          response!.joinedCommunities!
              .map((e) => e.uid)
              .whereType<String>()
              .toList(),
        );
      }

      return communityUids.toSet().toList();
    } catch (e) {
      print('Error fetching communities from API: $e');
      return [];
    }
  }

  Future<void> _onJoinOrLeave(
    JoinOrLeave event,
    Emitter<JoinLeaveCommunityState> emit,
  ) async {
    final box = await _getBox();
    if (box == null) return;

    try {
      final isCurrentlyJoined = state.userCommunities.contains(event.userUid);
      final updatedCommunities = Set<String>.from(state.userCommunities);

      if (isCurrentlyJoined) {
        updatedCommunities.remove(event.userUid);
        await _handleLeave(event.userUid);
      } else {
        updatedCommunities.add(event.userUid);
        await _handleJoin(event.userUid);
      }

      emit(state.copyWith(userCommunities: updatedCommunities));
      await _persistUserCommunities(box, updatedCommunities);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to toggle community membership'));
    }
  }

  Future<void> _handleJoin(String userUid) async {
    try {
      await CommunityApi.joinCommunity(
        joineeUserUid: AuthUserDb.getLastLoggedUserUid()!,
        communityUid: userUid,
      );
    } catch (e) {
      print('Error following user: $e');
    }
  }

  Future<void> _handleLeave(String userUid) async {
    try {
      await CommunityApi.leaveCommunity(
        memberUserUid: AuthUserDb.getLastLoggedUserUid()!,
        communityUid: userUid,
      );
    } catch (e) {
      print('Error unfollowing user: $e');
    }
  }

  Future<void> _persistUserCommunities(
    Box? box,    // Change parameter to be nullable
    Set<String> communityIds,
  ) async {
    if (box == null) return;    // Add null check
    try {
      await box.put('userCommunities', communityIds.toList());    // Use simple key name
    } catch (e) {
      print('Error persisting user communities to cache: $e');
    }
  }
}
