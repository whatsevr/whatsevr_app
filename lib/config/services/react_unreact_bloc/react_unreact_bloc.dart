import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:whatsevr_app/config/api/methods/reactions.dart';
import 'package:whatsevr_app/config/api/response_model/reactions/user_reacted_items.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

part 'react_unreact_event.dart';
part 'react_unreact_state.dart';

// Bloc
class ReactUnreactBloc extends Bloc<ReactUnreactEvent, ReactUnreactState> {
  static const String _totalPagesKey = 'totalPages';
  static const int _pageSize = 500;
  String? _reactedItemsBox;
  Set<String> _reactedItemIds = {};

  ReactUnreactBloc() : super(const ReactUnreactState(reactedItemIds: {})) {
    on<FetchReactions>(_onFetchReactions);
    on<ToggleReaction>(_onToggleReaction);
  }

  Future<Box?> _getBox() async {
    final String? userUid = AuthUserDb.getLastLoggedUserUid();
    if (userUid == null) return null;
    _reactedItemsBox = 'reactedItemsBox_$userUid';
    if (!Hive.isBoxOpen(_reactedItemsBox!)) {
      await Hive.openBox(_reactedItemsBox!);
    }
    return Hive.box(_reactedItemsBox!);
  }

  Future<void> _onFetchReactions(
    FetchReactions event,
    Emitter<ReactUnreactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      _reactedItemIds.clear();
      emit(state.copyWith(reactedItemIds: _reactedItemIds));
      final box = await _getBox();
      if (box != null) {
        await _loadCachedReactions(box);
        await _fetchAndCacheReactions(box);
        emit(
          state.copyWith(
            reactedItemIds: _reactedItemIds,
            isLoading: false,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, error: 'User not logged in'));
      }
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: 'Failed to fetch reactions'),
      );
    }
  }

  Future<void> _fetchAndCacheReactions(Box box) async {
    int page = 1;
    final List<String> allReactions = [];

    while (true) {
      final List<String> currentPageReactions =
          await _fetchReactionsFromApi(page);
      if (currentPageReactions.isEmpty) break;

      allReactions.addAll(currentPageReactions);
      await box.put(
        '$_reactedItemsBox$page',
        currentPageReactions,
      ); // Cache by page
      page++;
    }

    _reactedItemIds = Set.from(allReactions); // Update in-memory set
    await box.put(_totalPagesKey, page - 1); // Store total pages count
  }

  Future<void> _loadCachedReactions(Box box) async {
    final int totalPages = box.get(_totalPagesKey, defaultValue: 0);
    final List<String> allReactions = [];

    for (int page = 1; page <= totalPages; page++) {
      final List<dynamic>? pageData = box.get('$_reactedItemsBox$page');
      if (pageData != null) {
        allReactions.addAll(pageData.cast<String>());
      }
    }

    _reactedItemIds = Set.from(allReactions);
  }

  Future<List<String>> _fetchReactionsFromApi(int page) async {
    try {
      final UserReactedItemsResponse? response =
          await ReactionsApi.getUserReactedItems(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        page: page,
        pageSize: _pageSize,
      );
      List<String?> uids = response?.data
              ?.map(
                (e) =>
                    e.videoPostUid ??
                    e.flickPostUid ??
                    e.memoryUid ??
                    e.offerPostUid ??
                    e.photoPostUid ??
                    e.pdfUid,
              )
              .toList() ??
          [];
      uids = uids.toSet().toList();
      return uids.whereType<String>().toList();
    } catch (e) {
      print('Error fetching reactions from API: $e');
      return [];
    }
  }

  Future<void> _onToggleReaction(
    ToggleReaction event,
    Emitter<ReactUnreactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final box = await _getBox();
      final String? contentUid = event.videoPostUid ??
          event.flickPostUid ??
          event.memoryUid ??
          event.offerPostUid ??
          event.photoPostUid ??
          event.pdfUid;

      if (contentUid == null) return;

      if (_reactedItemIds.contains(contentUid)) {
        _reactedItemIds.remove(contentUid);
        await _handleUnreact(
          event.videoPostUid,
          event.flickPostUid,
          event.memoryUid,
          event.offerPostUid,
          event.photoPostUid,
          event.pdfUid,
        );
      } else {
        _reactedItemIds.add(contentUid);
        await _handleReact(
          event.reactionType!,
          event.videoPostUid,
          event.flickPostUid,
          event.memoryUid,
          event.offerPostUid,
          event.photoPostUid,
          event.pdfUid,
        );
      }

      await _persistReactions(box);
      emit(state.copyWith(reactedItemIds: _reactedItemIds, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(error: 'Failed to toggle reaction', isLoading: false),
      );
    }
  }

  Future<void> _handleReact(
    String reactionType,
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  ) async {
    try {
      await ReactionsApi.recordReaction(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        reactionType: reactionType,
        videoPostUid: videoPostUid,
        flickPostUid: flickPostUid,
        memoryUid: memoryUid,
        offerPostUid: offerPostUid,
        photoPostUid: photoPostUid,
        pdfUid: pdfUid,
      );
    } catch (e) {
      print('Error reacting to item: $e');
    }
  }

  Future<void> _handleUnreact(
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  ) async {
    try {
      await ReactionsApi.deleteReaction(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        videoPostUid: videoPostUid,
        flickPostUid: flickPostUid,
        memoryUid: memoryUid,
        offerPostUid: offerPostUid,
        photoPostUid: photoPostUid,
        pdfUid: pdfUid,
      );
    } catch (e) {
      print('Error unreacting to item: $e');
    }
  }

  Future<void> _persistReactions(Box? box) async {
    if (box == null) return;
    try {
      await box.put('reactedItemIds', _reactedItemIds.toList());
    } catch (e) {
      print('Error persisting reactions to cache: $e');
    }
  }
}
