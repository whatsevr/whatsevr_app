class UiMemoryGroup {
  final String? userUid;
  final String? username;
  final String? profilePicture;
  final List<UiMemoryGroupItems?> uiMemoryGroupItems;

  UiMemoryGroup({
    required this.userUid,
    required this.username,
    required this.profilePicture,
    required this.uiMemoryGroupItems,
  });
}

class UiMemoryGroupItems {
  final String? imageUrl;
  final String? videoUrl;
  final String? caption;
  final String? ctaAction;
  final String? ctaActionUrl;
  final int? videoDurationMs;
  final bool? isImage;
  final bool? isVideo;
  final DateTime? createdAt;
  UiMemoryGroupItems({
    this.imageUrl,
    this.videoUrl,
    this.caption,
    this.ctaAction,
    this.ctaActionUrl,
    this.videoDurationMs,
    this.isImage,
    this.isVideo,
    this.createdAt,
  });
}
