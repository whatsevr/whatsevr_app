import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/response_model/community/user_communities.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

part 'join_leave_community_event.dart';
part 'join_leave_community_state.dart';

class JoinLeaveCommunityBloc
    extends Bloc<JoinLeaveCommunityEvent, JoinLeaveCommunityState> {
  static String? _userOwnedCommunitiesBox;
  static String? _userJoinedCommunitiesBox;
  JoinLeaveCommunityBloc()
      : super(const JoinLeaveCommunityState(userJoinedCommunityUids: {})) {
    on<FetchUserCommunities>(_onFetchUserCommunities);
    on<JoinOrLeave>(_onJoinOrLeave);
    on<ReloadUserCommunities>(_onReloadUserCommunities);
  }

  Future<(Box?, Box?)> _getBoxes() async {
    final String? userUid = AuthUserDb.getLastLoggedUserUid();
    if (userUid == null) return (null, null);

    _userOwnedCommunitiesBox = 'ownedCommunitiesBox_$userUid';
    _userJoinedCommunitiesBox = 'joinedCommunitiesBox_$userUid';

    if (!Hive.isBoxOpen(_userOwnedCommunitiesBox!)) {
      await Hive.openBox(_userOwnedCommunitiesBox!);
    }
    if (!Hive.isBoxOpen(_userJoinedCommunitiesBox!)) {
      await Hive.openBox(_userJoinedCommunitiesBox!);
    }

    return (
      Hive.box(_userOwnedCommunitiesBox!),
      Hive.box(_userJoinedCommunitiesBox!)
    );
  }

  Future<void> _onFetchUserCommunities(
    FetchUserCommunities event,
    Emitter<JoinLeaveCommunityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final (Box? ownedBox, Box? joinedBox) = await _getBoxes();
      if (ownedBox == null || joinedBox == null) {
        emit(state.copyWith(isLoading: false, error: 'User not logged in'));
        return;
      }

      // Load from cache first
      final List<dynamic>? cachedOwnedCommunities =
          ownedBox.get('ownedCommunities');
      final List<dynamic>? cachedJoinedCommunities =
          joinedBox.get('joinedCommunities');

      if (cachedOwnedCommunities != null || cachedJoinedCommunities != null) {
        emit(state.copyWith(
          userOwnedCommunityUids: cachedOwnedCommunities != null
              ? Set.from(cachedOwnedCommunities.cast<String>())
              : {},
          userJoinedCommunityUids: cachedJoinedCommunities != null
              ? Set.from(cachedJoinedCommunities.cast<String>())
              : {},
        ));
      }

      // Fetch from API
      final (List<String>, List<String>)? communitiesUids =
          await _fetchUserCommunitiesFromApi();
      if (communitiesUids == null) return;
      final List<String> ownedCommunities = communitiesUids.$1;
      final List<String> joinedCommunities = communitiesUids.$2;

      emit(state.copyWith(
        userJoinedCommunityUids: Set.from(joinedCommunities),
        userOwnedCommunityUids: Set.from(ownedCommunities),
        isLoading: false,
      ));

      // Persist to separate boxes
      await ownedBox.put('ownedCommunities', ownedCommunities);
      await joinedBox.put('joinedCommunities', joinedCommunities);
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to fetch user communities',
      ));
    }
  }

  Future<void> _onReloadUserCommunities(
    ReloadUserCommunities event,
    Emitter<JoinLeaveCommunityState> emit,
  ) async {
    final (Box? ownedBox, Box? joinedBox) = await _getBoxes();
    if (ownedBox == null || joinedBox == null) return;

    try {
      final List<dynamic>? cachedOwnedCommunities =
          ownedBox.get('ownedCommunities');
      final List<dynamic>? cachedJoinedCommunities =
          joinedBox.get('joinedCommunities');

      emit(state.copyWith(
        userOwnedCommunityUids: cachedOwnedCommunities != null
            ? Set.from(cachedOwnedCommunities.cast<String>())
            : {},
        userJoinedCommunityUids: cachedJoinedCommunities != null
            ? Set.from(cachedJoinedCommunities.cast<String>())
            : {},
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to reload communities'));
    }
  }

  Future<
      (
        List<String> ownedCommunityUids,
        List<String> joinedCommunityUids,
      )?> _fetchUserCommunitiesFromApi() async {
    try {
      final UserCommunitiesResponse? response =
          await CommunityApi.getUserCommunities(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
      );

      if (response == null ||
          ((response.userCommunities == null ||
                  response.userCommunities!.isEmpty) &&
              (response.joinedCommunities == null ||
                  response.joinedCommunities!.isEmpty))) {
        return null;
      }

      final List<String> userCommunitiesUids = [];
      final List<String> joinedCommunitiesUids = [];
      if (response.userCommunities != null) {
        userCommunitiesUids.addAll(
          response.userCommunities!
              .map((e) => e.uid)
              .whereType<String>()
              .toList(),
        );
      }

      if (response.joinedCommunities != null) {
        joinedCommunitiesUids.addAll(
          response.joinedCommunities!
              .map((e) => e.uid)
              .whereType<String>()
              .toList(),
        );
      }

      return (userCommunitiesUids, joinedCommunitiesUids);
    } catch (e) {
      print('Error fetching communities from API: $e');
      return null;
    }
  }

  Future<void> _onJoinOrLeave(
    JoinOrLeave event,
    Emitter<JoinLeaveCommunityState> emit,
  ) async {
    final (Box? ownedBox, Box? joinedBox) = await _getBoxes();
    if (ownedBox == null || joinedBox == null) return;

    try {
      final isCurrentlyJoined =
          state.userJoinedCommunityUids.contains(event.userUid);
      final updatedJoinedCommunities =
          Set<String>.from(state.userJoinedCommunityUids);

      if (isCurrentlyJoined) {
        updatedJoinedCommunities.remove(event.userUid);
        await _handleLeave(event.userUid);
      } else {
        updatedJoinedCommunities.add(event.userUid);
        await _handleJoin(event.userUid);
      }

      emit(state.copyWith(userJoinedCommunityUids: updatedJoinedCommunities));
      await _persistUserCommunities(
        ownedBox,
        joinedBox,
        state.userOwnedCommunityUids,
        updatedJoinedCommunities,
      );
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
    Box? ownedBox,
    Box? joinedBox,
    Set<String> ownedCommunityIds,
    Set<String> joinedCommunityIds,
  ) async {
    if (ownedBox == null || joinedBox == null) return;
    try {
      await ownedBox.put('ownedCommunities', ownedCommunityIds.toList());
      await joinedBox.put('joinedCommunities', joinedCommunityIds.toList());
    } catch (e) {
      print('Error persisting user communities to cache: $e');
    }
  }
}
