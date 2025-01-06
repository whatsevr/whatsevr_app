part of '../page.dart';

enum ActivityType {
  viewed,    // from tracked_activities
  reacted,   // from user_reactions
  commented, // from user_comments
  shared     // from tracked_activities
}

enum ContentType {
  wtv,
  flick,
  photo,
  offer,
  memory,
  pdf
}

// Add TimeFilter enum
enum TimeFilter {
  thisWeek,
  allTime
}

class ActivityItem {
  final String uid;          // Unique identifier for the activity
  final String userUid;      // From users table
  final DateTime timestamp;
  final ActivityType type;
  final ContentType contentType;
  final String? contentUid;  // UUID of the related content
  final String? contentTitle;
  final String? contentThumbnail;
  final String? description;
  final String? location;
  final bool isRead;
  
  // New fields from schema
  final String? deviceOs;           // from tracked_activities
  final String? deviceModel;        // from tracked_activities
  final String? appVersion;         // from tracked_activities
  final String? geoLocation;        // from tracked_activities
  final String? reactionType;       // from user_reactions
  final String? commentText;        // from user_comments
  final String? commentImageUrl;    // from user_comments
  final int? videoDurationInSec;    // from wtvs/flicks
  final int? totalViews;           // from content tables
  final int? totalLikes;           // from content tables
  final int? totalComments;        // from content tables
  final int? totalShares;          // from content tables
  final double? cumulativeScore;    // from content tables
  final List<String>? hashtags;     // from content tables
  final List<String>? taggedUsers;  // from content tables
  final String? ctaAction;          // from offers/memories
  final String? ctaActionUrl;       // from offers/memories

  ActivityItem({
    required this.uid,
    required this.userUid,
    required this.timestamp,
    required this.type,
    required this.contentType,
    this.contentUid,
    this.contentTitle,
    this.contentThumbnail,
    this.description,
    this.location,
    this.isRead = false,
    // New fields
    this.deviceOs,
    this.deviceModel,
    this.appVersion,
    this.geoLocation,
    this.reactionType,
    this.commentText,
    this.commentImageUrl,
    this.videoDurationInSec,
    this.totalViews,
    this.totalLikes,
    this.totalComments,
    this.totalShares,
    this.cumulativeScore,
    this.hashtags,
    this.taggedUsers,
    this.ctaAction,
    this.ctaActionUrl,
  });

  static String getActivityDescription(ActivityType type, ContentType contentType, String? title) {
    switch (type) {
      case ActivityType.viewed:
        return 'Viewed ${contentType.name} "${title ?? ''}"';
      case ActivityType.reacted:
        return 'Liked ${contentType.name} "${title ?? ''}"';
      case ActivityType.commented:
        return 'Commented on ${contentType.name} "${title ?? ''}"';
  
      case ActivityType.shared:
        return 'Shared ${contentType.name} "${title ?? ''}"';
    }
  }

  static IconData getContentTypeIcon(ContentType type) {
    switch (type) {
      case ContentType.wtv:
        return Icons.video_library;
      case ContentType.flick:
        return Icons.movie;
      case ContentType.photo:
        return Icons.image;
      case ContentType.offer:
        return Icons.local_offer;
      case ContentType.memory:
        return Icons.memory;
      case ContentType.pdf:
        return Icons.picture_as_pdf;
    }
  }
}

class _SampleActivityData {
  static List<ActivityItem> activities = [
    // WTV Activities with complete metadata
    ActivityItem(
      uid: "wtv1",
      userUid: "user1",
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      type: ActivityType.viewed,
      contentType: ContentType.wtv,
      contentTitle: "How to Master Flutter Development",
      contentThumbnail: "https://picsum.photos/800/450?random=1",
      description: "A comprehensive guide to Flutter",
      isRead: true,
      deviceOs: "iOS 17.2",
      deviceModel: "iPhone 15 Pro",
      appVersion: "2.1.0",
      geoLocation: "New York, USA",
      videoDurationInSec: 1800, // 30 minutes
      totalViews: 15420,
      totalLikes: 1243,
      totalComments: 89,
      totalShares: 156,
      cumulativeScore: 4.8,
      hashtags: ["flutter", "programming", "mobile", "development"],
      taggedUsers: ["@flutter_dev", "@code_master"],
    ),

    // Flick with reactions and comments
    ActivityItem(
      uid: "flick1",
      userUid: "user1",
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: ActivityType.reacted,
      contentType: ContentType.flick,
      contentTitle: "Daily Coding Tips",
      contentThumbnail: "https://picsum.photos/800/450?random=2",
      description: "Quick tips for better code",
      isRead: false,
      reactionType: "heart",
      videoDurationInSec: 180, // 3 minutes
      totalViews: 5632,
      totalLikes: 892,
      totalComments: 45,
      hashtags: ["coding", "tips", "programming"],
      deviceModel: "Pixel 7 Pro",
      deviceOs: "Android 14",
    ),

    // Photo with comment interaction
    ActivityItem(
      uid: "photo1",
      userUid: "user1",
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      type: ActivityType.commented,
      contentType: ContentType.photo,
      contentTitle: "UI Design Showcase",
      contentThumbnail: "https://picsum.photos/800/450?random=3",
      description: "Latest design work",
      isRead: true,
      commentText: "Love the clean design approach! 🎨",
      totalLikes: 324,
      totalComments: 28,
      location: "San Francisco, CA",
      hashtags: ["design", "ui", "minimal"],
      taggedUsers: ["@design_team"],
    ),

    // Offer with CTA
    ActivityItem(
      uid: "offer1",
      userUid: "user1",
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      type: ActivityType.shared,
      contentType: ContentType.offer,
      contentTitle: "Special Flutter Course Discount",
      contentThumbnail: "https://picsum.photos/800/450?random=4",
      description: "Limited time 50% off on all courses",
      isRead: true,
      ctaAction: "Get Discount",
      ctaActionUrl: "https://example.com/course",
      totalShares: 234,
      totalViews: 1892,
      geoLocation: "Global",
      hashtags: ["education", "flutter", "discount"],
    ),

    // Memory with location and stats
    ActivityItem(
      uid: "memory1",
      userUid: "user1",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: ActivityType.commented,
      contentType: ContentType.memory,
      contentTitle: "Team Hackathon 2024",
      contentThumbnail: "https://picsum.photos/800/450?random=5",
      description: "Amazing experience with the team",
      isRead: true,
      location: "Tech Hub, Silicon Valley",
      totalLikes: 567,
      totalComments: 45,
      totalShares: 23,
      hashtags: ["hackathon", "team", "coding"],
      taggedUsers: ["@team_lead", "@dev_squad"],
      ctaAction: "View Story",
      ctaActionUrl: "memory://story/123",
    ),

    // PDF Document
    ActivityItem(
      uid: "pdf1",
      userUid: "user1",
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: ActivityType.viewed,
      contentType: ContentType.pdf,
      contentTitle: "Flutter Architecture Guidelines",
      contentThumbnail: "https://picsum.photos/800/450?random=6",
      description: "Official documentation for Flutter architecture",
      isRead: true,
      totalViews: 892,
    
      deviceOs: "macOS 14.2",
      deviceModel: "MacBook Pro",
      appVersion: "2.1.0",
      hashtags: ["documentation", "flutter", "architecture"],
    ),
  ];

  static List<ActivityItem> getFilteredActivities(ActivityType? activityFilter, ContentType? contentFilter) {
    return activities.where((activity) {
      bool matchesActivityType = activityFilter == null || activity.type == activityFilter;
      bool matchesContentType = contentFilter == null || activity.contentType == contentFilter;
      return matchesActivityType && matchesContentType;
    }).toList();
  }
}

class _HistoryView extends StatefulWidget {
  const _HistoryView({super.key});

  @override
  State<_HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<_HistoryView> {
  TimeFilter _selectedTimeFilter = TimeFilter.thisWeek;

  bool _hasNewNotifications = false;
  late List<ActivityItem> _activities;

  @override
  void initState() {
    super.initState();
    _activities = _SampleActivityData.activities;
  }

  List<ActivityItem> _getFilteredActivities() {
    if (_selectedTimeFilter == TimeFilter.thisWeek) {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      return _activities.where((activity) => activity.timestamp.isAfter(weekAgo)).toList();
    }
    return _activities;
  }

  @override
  Widget build(BuildContext context) {
    final filteredActivities = _getFilteredActivities();
    
    return Column(
      children: [
       
    
        // Activities list
        Expanded(
          child: ListView.builder(
            itemCount: filteredActivities.length,
            itemBuilder: (context, index) {
              final activity = filteredActivities[index];
              return _ActivityTile(activity: activity); 
            },
          ),
        ),
         // Time filter section
        Container(
          decoration: BoxDecoration(
            color: context.whatsevrTheme.surface,
          ),
          child: _buildTimeFilterChips(),
        ),
      ],
    );
  }

  Widget _buildTimeFilterChips() {
    return Padding(
      padding: 
      EdgeInsets.symmetric(
        horizontal: context.whatsevrTheme.spacing2,
        vertical: context.whatsevrTheme.spacing2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final filter in TimeFilter.values)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.whatsevrTheme.spacing1,
              ),
              child: ChoiceChip(
                label: Text(
                  filter == TimeFilter.thisWeek ? 'This Week' : 'All Time',
                  style: TextStyle(
                    color: _selectedTimeFilter == filter
                        ? context.whatsevrTheme.surface
                        : context.whatsevrTheme.text,
                  ),
                ),
                selected: _selectedTimeFilter == filter,
                onSelected: (selected) {
                  if (selected) {
                    setState(() => _selectedTimeFilter = filter);
                  }
                },
                backgroundColor: context.whatsevrTheme.surface.withOpacity(0.9),
                selectedColor: context.whatsevrTheme.accent,
              ),
            ),
        ],
      ),
    );
  }

}


class _ActivityTile extends StatelessWidget {
  final ActivityItem activity;

  const _ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.whatsevrTheme.spacing2,
        vertical: context.whatsevrTheme.spacing1 / 2,
      ),
      decoration: BoxDecoration(
        color: context.whatsevrTheme.surface,
        borderRadius: context.whatsevrTheme.borderRadiusSmall,
        border: Border.all(
          color: activity.isRead 
              ? context.whatsevrTheme.divider 
              : context.whatsevrTheme.accent,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: context.whatsevrTheme.borderRadiusSmall,
        onTap: () {
          // Handle activity tap
        },
        child: Padding(
          padding: EdgeInsets.all(context.whatsevrTheme.spacing2),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content thumbnail with overlay icon
                if (activity.contentThumbnail != null)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: context.whatsevrTheme.borderRadiusSmall,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(
                            activity.contentThumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Content type indicator overlay
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: context.whatsevrTheme.surface.withOpacity(0.8),
                            borderRadius: context.whatsevrTheme.borderRadiusSmall,
                          ),
                          child: Icon(
                            ActivityItem.getContentTypeIcon(activity.contentType),
                            size: 12,
                            color: _getActionColor(context, activity.type),
                          ),
                        ),
                      ),
                    ],
                  ),
                const Gap(12),
                
                // Content details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Action and timestamp row
                      Row(
                        children: [
                          Icon(
                            _getActionIcon(activity.type),
                            size: 16,
                            color: _getActionColor(context, activity.type),
                          ),
                          const Gap(4),
                          Text(
                            _getActionText(activity.type),
                            style: context.whatsevrTheme.caption.copyWith(
                              color: _getActionColor(context, activity.type),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: context.whatsevrTheme.background,
                              borderRadius: context.whatsevrTheme.borderRadiusSmall,
                              border: Border.all(color: context.whatsevrTheme.divider),
                            ),
                            child: Text(
                              activity.contentType.name.toUpperCase(),
                              style: context.whatsevrTheme.caption.copyWith(
                                fontSize: 10,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatTimestamp(activity.timestamp),
                            style: context.whatsevrTheme.caption,
                          ),
                        ],
                      ),
                      const Gap(4),
                      
                      // Content title with truncation indicator
                      Text(
                        activity.contentTitle ?? '',
                        style: context.whatsevrTheme.subtitle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(2),
                      
                      // Description with metadata
                      if (activity.description != null) ...[
                        Text(
                          activity.description!,
                          style: context.whatsevrTheme.caption.copyWith(
                            color: context.whatsevrTheme.textLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(4),
                      ],
                      
                      // Bottom metadata row with stats
                      Row(
                        children: [
                          if (activity.location != null) ...[
                            Icon(
                              Icons.location_on,
                              size: 12,
                              color: context.whatsevrTheme.textLight,
                            ),
                            const Gap(2),
                            Expanded(
                              child: Text(
                                activity.location!,
                                style: context.whatsevrTheme.caption.copyWith(
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          if (!activity.isRead)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: context.whatsevrTheme.accent.withOpacity(0.1),
                                borderRadius: context.whatsevrTheme.borderRadiusSmall,
                              ),
                              child: Text(
                                'NEW',
                                style: context.whatsevrTheme.caption.copyWith(
                                  color: context.whatsevrTheme.accent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Content Stats Row
                      if (_hasStats)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              if (activity.totalViews != null) ...[
                                Icon(Icons.visibility_outlined, size: 12),
                                Text(
                                  formatNumber(activity.totalViews!),
                                  style: context.whatsevrTheme.caption,
                                ),
                                const Gap(8),
                              ],
                              if (activity.totalLikes != null) ...[
                                Icon(Icons.favorite_outline, size: 12),
                                Text(
                                  formatNumber(activity.totalLikes!),
                                  style: context.whatsevrTheme.caption,
                                ),
                                const Gap(8),
                              ],
                              if (activity.totalComments != null) ...[
                                Icon(Icons.comment_outlined, size: 12),
                                Text(
                                  formatNumber(activity.totalComments!),
                                  style: context.whatsevrTheme.caption,
                                ),
                              ],
                            ],
                          ),
                        ),

                      // Duration & Device Info
                      if (_hasDeviceInfo)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              if (activity.videoDurationInSec != null) ...[
                                Icon(Icons.timer_outlined, size: 12),
                                Text(
                                  formatDuration(activity.videoDurationInSec!),
                                  style: context.whatsevrTheme.caption,
                                ),
                                const Gap(8),
                              ],
                              if (activity.deviceModel != null) ...[
                                Icon(Icons.devices_outlined, size: 12),
                                Text(
                                  activity.deviceModel!,
                                  style: context.whatsevrTheme.caption,
                                ),
                              ],
                            ],
                          ),
                        ),

                      // Hashtags
                      if (activity.hashtags?.isNotEmpty ?? false)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Wrap(
                            spacing: 4,
                            children: activity.hashtags!.map((tag) => 
                              Text(
                                '#$tag',
                                style: context.whatsevrTheme.caption.copyWith(
                                  color: context.whatsevrTheme.accent,
                                ),
                              ),
                            ).toList(),
                          ),
                        ),

                      // CTA Button for offers
                      if (activity.ctaAction != null)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle CTA
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.whatsevrTheme.accent,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              minimumSize: Size(0, 32),
                            ),
                            child: Text(activity.ctaAction!),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _hasStats => 
    activity.totalViews != null || 
    activity.totalLikes != null || 
    activity.totalComments != null;

  bool get _hasDeviceInfo =>
    activity.deviceModel != null ||
    activity.videoDurationInSec != null;

  String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  IconData _getActionIcon(ActivityType type) {
    switch (type) {
      case ActivityType.viewed:
        return Icons.visibility;
      case ActivityType.reacted:
        return Icons.favorite;
      case ActivityType.commented:
        return Icons.comment;
     
      case ActivityType.shared:
        return Icons.share;
    }
  }

  String _getActionText(ActivityType type) {
    switch (type) {
      case ActivityType.viewed:
        return 'Viewed';
      case ActivityType.reacted:
        return 'Liked';
      case ActivityType.commented:
        return 'Commented';
  
      case ActivityType.shared:
        return 'Shared';
    }
  }

  Color _getActionColor(BuildContext context, ActivityType type) {
    switch (type) {
      case ActivityType.viewed:
        return context.whatsevrTheme.info;
      case ActivityType.reacted:
        return Colors.red;
      case ActivityType.commented:
        return context.whatsevrTheme.accent;
    
      case ActivityType.shared:
        return context.whatsevrTheme.warning;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}


