part of '../page.dart';

class _ActivityHistoryView extends StatelessWidget {
  const _ActivityHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.trackedActivities.length,
          itemBuilder: (context, index) {
            final activity = state.trackedActivities[index];
            return _ActivityTile(activity: activity);
          },
        );
      },
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final Activity activity;

  const _ActivityTile({required this.activity});

  String? get contentThumbnail {
    if (activity.wtv?.thumbnail != null) return activity.wtv?.thumbnail;
    if (activity.flick?.thumbnail != null) return activity.flick?.thumbnail;
    if (activity.photo?.thumbnail != null) return activity.photo?.thumbnail;
    if (activity.memory?.imageUrl != null) return activity.memory?.imageUrl;
    if (activity.pdf?.thumbnailUrl != null) return activity.pdf?.thumbnailUrl;
    return null;
  }

  String? get contentTitle {
    if (activity.wtv?.title != null) return activity.wtv?.title;
    if (activity.flick?.title != null) return activity.flick?.title;
    if (activity.photo?.title != null) return activity.photo?.title;
    if (activity.memory?.caption != null) return activity.memory?.caption;
    if (activity.pdf?.title != null) return activity.pdf?.title;
    return null;
  }

  List<String>? get hashtags {
    if (activity.wtv?.hashtags != null) return activity.wtv?.hashtags;
    if (activity.flick?.hashtags != null) return activity.flick?.hashtags;
    if (activity.photo?.hashtags != null) return activity.photo?.hashtags;
    if (activity.memory?.hashtags != null) return activity.memory?.hashtags;
    return null;
  }

  String? get location {
    if (activity.wtv?.location != null) return activity.wtv?.location;
    if (activity.flick?.location != null) return activity.flick?.location;
    if (activity.photo?.location != null) return activity.photo?.location;
    if (activity.memory?.location != null) return activity.memory?.location;
    return activity.geoLocation;
  }

  int? get totalViews {
    if (activity.wtv?.totalViews != null) return activity.wtv?.totalViews;
    if (activity.flick?.totalViews != null) return activity.flick?.totalViews;
    if (activity.photo?.totalViews != null) return activity.photo?.totalViews;
    if (activity.memory?.totalViews != null) return activity.memory?.totalViews;
    return null;
  }

  int? get totalLikes {
    if (activity.wtv?.totalLikes != null) return activity.wtv?.totalLikes;
    if (activity.flick?.totalLikes != null) return activity.flick?.totalLikes;
    if (activity.photo?.totalLikes != null) return activity.photo?.totalLikes;
    if (activity.memory?.totalLikes != null) return activity.memory?.totalLikes;
    return null;
  }

  int? get totalComments {
    if (activity.wtv?.totalComments != null) return activity.wtv?.totalComments;
    if (activity.flick?.totalComments != null) return activity.flick?.totalComments;
    if (activity.photo?.totalComments != null) return activity.photo?.totalComments;
    if (activity.memory?.totalComments != null) return activity.memory?.totalComments;
    return null;
  }

  int? get videoDurationInSec {
    if (activity.wtv?.videoDurationInSec != null) return activity.wtv?.videoDurationInSec;
    if (activity.flick?.videoDurationInSec != null) return activity.flick?.videoDurationInSec;
    return null;
  }

  WhatsevrActivityType get type {
    return activity.activityType?.toLowerCase() == 'view' 
        ? WhatsevrActivityType.view
        : activity.activityType?.toLowerCase() == 'react'
            ? WhatsevrActivityType.react
            : activity.activityType?.toLowerCase() == 'comment'
                ? WhatsevrActivityType.comment
                : activity.activityType?.toLowerCase() == 'share'
                    ? WhatsevrActivityType.share
                    : WhatsevrActivityType.system;
  }

  WhatsevrContentType? get contentType {
    if (activity.wtvUid != null) return WhatsevrContentType.wtv;
    if (activity.flickUid != null) return WhatsevrContentType.flick;
    if (activity.photoUid != null) return WhatsevrContentType.photo;
    if (activity.memoryUid != null) return WhatsevrContentType.memory;
    if (activity.pdfUid != null) return WhatsevrContentType.pdf;
    return null;
  }

  IconData? getContentTypeIcon(WhatsevrContentType? type) {
    switch (type) {
      case WhatsevrContentType.wtv:
        return Icons.video_library;
      case WhatsevrContentType.flick:
        return Icons.movie;
      case WhatsevrContentType.photo:
        return Icons.photo;
      case WhatsevrContentType.memory:
        return Icons.memory;
      case WhatsevrContentType.pdf:
        return Icons.picture_as_pdf;
      default:
        return null;
    }
  }

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
          color: context.whatsevrTheme.divider,
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
                if (contentThumbnail != null)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: context.whatsevrTheme.borderRadiusSmall,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(
                            contentThumbnail!,
                            fit: BoxFit.cover,
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
                            _getActionIcon(type),
                            size: 16,
                            color: _getActionColor(context, type),
                          ),
                          const Gap(4),
                          Text(
                            _getActionText(type),
                            style: context.whatsevrTheme.caption.copyWith(
                              color: _getActionColor(context, type),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if(contentType != null) 
                          ...[const Gap(8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: context.whatsevrTheme.background,
                              borderRadius:
                                  context.whatsevrTheme.borderRadiusSmall,
                              border: Border.all(
                                  color: context.whatsevrTheme.divider),
                            ),
                            child: Text(
                              '${contentType?.name.toUpperCase()}',
                              style: context.whatsevrTheme.caption.copyWith(
                                fontSize: 10,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )],
                          const Spacer(),
                          Text(
                            _formatTimestamp(activity.activityAt!),
                            style: context.whatsevrTheme.caption,
                          ),
                        ],
                      ),
                      const Gap(4),

                      // Content title with truncation indicator
                      Text(
                        contentTitle ?? '',
                        style: context.whatsevrTheme.subtitle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(2),

                      

                      // Device Info
                      if (activity.deviceModel != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(

                            children: [
                             
                              if (activity.deviceModel != null) ...[
                                Icon(Icons.devices_outlined, size: 12),
                                Gap(4),
                                Text(
                                  activity.deviceModel!,
                                  style: context.whatsevrTheme.caption,
                                ),
                              ],
                            ],
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

  IconData _getActionIcon(WhatsevrActivityType type) {
    switch (type) {
      case WhatsevrActivityType.view:
        return Icons.visibility;
      case WhatsevrActivityType.react:
        return Icons.favorite;
      case WhatsevrActivityType.comment:
        return Icons.comment;
      case WhatsevrActivityType.share:
        return Icons.share;
      case WhatsevrActivityType.system:
        return Icons.system_update;
    }
  }

  String _getActionText(WhatsevrActivityType type) {
    switch (type) {
      case WhatsevrActivityType.view:
        return 'Viewed';
      case WhatsevrActivityType.react:
        return 'Liked';
      case WhatsevrActivityType.comment:
        return 'Commented';
      case WhatsevrActivityType.share:
        return 'Shared';
      case WhatsevrActivityType.system:
        return 'System';
    }
  }

  Color _getActionColor(BuildContext context, WhatsevrActivityType type) {
    switch (type) {
      case WhatsevrActivityType.view:
        return context.whatsevrTheme.info;
      case WhatsevrActivityType.react:
        return Colors.red;
      case WhatsevrActivityType.comment:
        return context.whatsevrTheme.accent;
      case WhatsevrActivityType.share:
        return context.whatsevrTheme.warning;
      case WhatsevrActivityType.system:
        return context.whatsevrTheme.disabled;
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
