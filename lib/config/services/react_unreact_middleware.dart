import 'package:hive/hive.dart';
import 'package:whatsevr_app/config/api/methods/reactions.dart';
import 'package:whatsevr_app/config/api/response_model/reactions/user_reacted_items.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';

class ReactUnreactMiddleware {
  static String? _reactionsBox;
  static const String _totalPagesKey = 'totalPages';
  static const int _pageSize = 500;
  static Set<String> reactedItemIds = {};

  // Lazy initialization for Hive Box
  static Future<Box?> _getBox() async {
    final String? userUid = AuthUserDb.getLastLoggedUserUid();
    if (userUid == null) return null;
    _reactionsBox = 'reactedItemsBox_$userUid';
    if (!Hive.isBoxOpen(_reactionsBox!)) {
      await Hive.openBox(_reactionsBox!);
    }
    return Hive.box(_reactionsBox!);
  }

  // Fetch and cache all reactions (one-time on app launch)
  static Future<void> fetchAndCacheReactions() async {
    final box = await _getBox();
    if (box == null) return;
    await _loadCachedReactions(); // Load from cache first

    int page = 1;
    final List<String> allReactions = [];

    while (true) {
      final List<String> currentPageReactions =
          await _fetchReactionsFromApi(page);
      if (currentPageReactions.isEmpty) break;

      allReactions.addAll(currentPageReactions);
      await box.put(
          '$_reactionsBox$page', currentPageReactions); // Cache by page
      page++;
    }

    reactedItemIds = Set.from(allReactions); // Update in-memory set
    await box.put(_totalPagesKey, page - 1); // Store total pages count
  }

  // Load cached reactions on app restart
  static Future<void> _loadCachedReactions() async {
    final box = await _getBox();
    if (box == null) return;
    final int totalPages = box.get(_totalPagesKey, defaultValue: 0);
    final List<String> allReactions = [];

    for (int page = 1; page <= totalPages; page++) {
      final List<dynamic>? pageData = box.get('$_reactionsBox$page');
      if (pageData != null) {
        allReactions.addAll(pageData.cast<String>());
      }
    }

    reactedItemIds = Set.from(allReactions); // Update in-memory
  }

  // Fetch reactions from the API (with pagination)
  static Future<List<String>> _fetchReactionsFromApi(int page) async {
    try {
      final UserReactedItemsResponse? response =
          await ReactionsApi.getUserReactedItems(
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        page: page,
        pageSize: _pageSize,
      );
      List<String?> uids = response?.data
              ?.map((e) =>
                  e.videoPostUid ??
                  e.flickPostUid ??
                  e.memoryUid ??
                  e.offerPostUid ??
                  e.photoPostUid ??
                  e.pdfUid)
              .toList() ??
          [];
      uids = uids.toSet().toList();
      return uids.whereType<String>().toList();
    } catch (e) {
      print('Error fetching reactions from API: $e');
      return [];
    }
  }

  // Toggle reaction for an item and persist the change
  static Future<void> toggleReaction({
    required String? reactionType,
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  }) async {
    final box = await _getBox();

    // Identify unique UID for the specific post type
    final String? contentUid = videoPostUid ??
        flickPostUid ??
        memoryUid ??
        offerPostUid ??
        photoPostUid ??
        pdfUid;
    if (contentUid == null) return;

    if (reactedItemIds.contains(contentUid)) {
      reactedItemIds.remove(contentUid);
      await _handleUnreact(
        videoPostUid: videoPostUid,
        flickPostUid: flickPostUid,
        memoryUid: memoryUid,
        offerPostUid: offerPostUid,
        photoPostUid: photoPostUid,
        pdfUid: pdfUid,
      );
    } else {
      reactedItemIds.add(contentUid);
      await _handleReact(
        reactionType: reactionType!,
        videoPostUid: videoPostUid,
        flickPostUid: flickPostUid,
        memoryUid: memoryUid,
        offerPostUid: offerPostUid,
        photoPostUid: photoPostUid,
        pdfUid: pdfUid,
      );
    }

    // Persist updated reactions without re-fetching
    await _persistReactions(box);
  }

  // Helper method to handle adding reaction
  static Future<void> _handleReact({
    required String reactionType,
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  }) async {
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

  // Helper method to handle removing reaction
  static Future<void> _handleUnreact({
    String? videoPostUid,
    String? flickPostUid,
    String? memoryUid,
    String? offerPostUid,
    String? photoPostUid,
    String? pdfUid,
  }) async {
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
      print('Error unreacting item: $e');
    }
  }

  // Check if a user has reacted to an item
  static bool hasReacted(String? contentUid) {
    if (contentUid == null) return false;
    return reactedItemIds.contains(contentUid);
  }

  // Persist the reacted items list to cache (batch updates)
  static Future<void> _persistReactions(Box? box) async {
    if (box == null) return;
    try {
      await box.put('reactedItemIds', reactedItemIds.toList());
    } catch (e) {
      print('Error persisting reactions to cache: $e');
    }
  }
}
