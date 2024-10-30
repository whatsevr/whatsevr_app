import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:story_view_advance/controller/story_controller.dart';
import 'package:story_view_advance/utils.dart';
import 'package:story_view_advance/widgets/story_view_advance.dart';

import '../../../../../../../../../config/services/launch_url.dart';
import '../../../../../../../../../config/widgets/links_preview_list.dart';
import '../../../../../config/mocks/mocks.dart';
import '../../../../../config/services/file_upload.dart';
import '../../../../../config/widgets/buttons/button.dart';
import '../../../../../config/widgets/dialogs/showAppModalSheet.dart';

showMemoriesPlayer(BuildContext context,
    {required List<UiMemoryGroup>? uiMemoryGroups,
    required int startGroupIndex,
    required int startMemoryIndex,}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return _MemoriesPlayer(
        uiMemoryGroups: uiMemoryGroups,
        startGroupIndex: startGroupIndex,
        startMemoryIndex: startMemoryIndex,
      );
    },
  );
}

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

class _MemoriesPlayer extends StatefulWidget {
  final List<UiMemoryGroup>? uiMemoryGroups;
  final int startGroupIndex;
  final int startMemoryIndex;
  const _MemoriesPlayer({
    required this.uiMemoryGroups,
    required this.startGroupIndex,
    required this.startMemoryIndex,
  });

  @override
  State<_MemoriesPlayer> createState() => _MemoriesPlayerState();
}

class _MemoriesPlayerState extends State<_MemoriesPlayer> {
  PageController? pageViewController;
  StoryController flutterStoryController = StoryController();
  Duration baseDuration = const Duration(seconds: 5);
  int currentPageIndex = 0;
  int currentMemoryIndex = 0;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.startGroupIndex;
    currentMemoryIndex = widget.startMemoryIndex;
    pageViewController = PageController(initialPage: widget.startGroupIndex);
    if (widget.startMemoryIndex != 0) {
      for (int i = 0; i < widget.startMemoryIndex; i++) {
        flutterStoryController.next();
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    pageViewController?.dispose();
    flutterStoryController.dispose();
    SmartDialog.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 16.0,
            backgroundImage: ExtendedNetworkImageProvider(
              widget.uiMemoryGroups?[currentPageIndex].profilePicture ??
                  MockData.blankProfileAvatar,
              cache: true,
            ),
          ),
        ),
        title: Text(
          widget.uiMemoryGroups?[currentPageIndex].username ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Text(
            GetTimeAgo.parse(
              widget.uiMemoryGroups![currentPageIndex]
                  .uiMemoryGroupItems[currentMemoryIndex]!.createdAt!,
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
          Gap(8),
        ],
      ),
      body: PageView.builder(
        controller: pageViewController,
        itemCount: widget.uiMemoryGroups?.length ?? 0,
        onPageChanged: (index) {
          currentPageIndex = index;
          setState(() {});
        },
        itemBuilder: (context, index) {
          final List<UiMemoryGroupItems?> uiMemoryData =
              widget.uiMemoryGroups?[index].uiMemoryGroupItems ?? [];
          return StoryView(
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down || direction == Direction.up) {
                Navigator.pop(context);
              }
            },
            storyItems: [
              for (int i = 0; i < (uiMemoryData.length); i++)
                uiMemoryData[i]?.isImage == true
                    ? StoryItem.pageImage(
                        controller: flutterStoryController,
                        url:
                            '${widget.uiMemoryGroups?[index].uiMemoryGroupItems[i]?.imageUrl}',
                        duration: baseDuration,
                      )
                    : uiMemoryData[i]?.isVideo == true
                        ? StoryItem.pageVideo(
                            generateOptimizedCloudinaryVideoUrl(
                                originalUrl:
                                    '${widget.uiMemoryGroups?[index].uiMemoryGroupItems[i]?.videoUrl}',),
                            controller: flutterStoryController,
                            duration: Duration(
                                milliseconds: widget
                                        .uiMemoryGroups?[index]
                                        .uiMemoryGroupItems[i]
                                        ?.videoDurationMs ??
                                    0,),
                            caption: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${widget.uiMemoryGroups?[index].uiMemoryGroupItems[i]?.caption}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Gap(50),
                              ],
                            ),
                          )
                        : StoryItem.text(
                            title:
                                'Unable to load content (Not an image or video)',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            backgroundColor: Colors.black,
                            duration: baseDuration,
                          ),
            ],
            controller: flutterStoryController,
            onStoryShow: (storyItem, index) {
              currentMemoryIndex = index;
              if ((uiMemoryData[index]?.ctaAction?.isNotEmpty ?? false) &&
                  (uiMemoryData[index]?.ctaActionUrl?.isNotEmpty ?? false)) {
                SmartDialog.show(
                  maskColor: Colors.transparent,
                  keepSingle: true,
                  clickMaskDismiss: false,
                  usePenetrate: true,
                  alignment: Alignment.bottomCenter,
                  builder: (context) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: WhatsevrButton.filled(
                              label:
                                  uiMemoryData[index]?.ctaAction ?? 'Open Link',
                              onPressed: () {
                                launchWebURL(context,
                                    url: uiMemoryData[index]?.ctaActionUrl ??
                                        '',);
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              flutterStoryController.pause();
                              showAppModalSheet(
                                  child: LinksPreviewListView(
                                urls: [uiMemoryData[index]?.ctaActionUrl ?? ''],
                              ),);
                            },
                            icon: const Icon(Icons.info_outline),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                SmartDialog.dismiss();
              }
            },
            repeat: widget.uiMemoryGroups?.length == 1,
            onComplete: () async {
              if (index < (widget.uiMemoryGroups?.length ?? 0) - 1) {
                pageViewController?.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
          );
        },
      ),
    );
  }
}
// class MemoriesPlayer extends StatefulWidget {
//   final List<RecommendedMemory>? memories;
//   final int index;
//   const MemoriesPlayer({
//     this.memories,
//     required this.index,
//   });
//
//   @override
//   State<MemoriesPlayer> createState() => _MemoriesPlayerState();
// }
//
// class _MemoriesPlayerState extends State<MemoriesPlayer> {
//   PageController? pageViewController;
//   StoryController flutterStoryController = StoryController();
//   Duration baseDuration = const Duration(seconds: 5);
//   int currentPageIndex = 0;
//   int currentMemoryIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     currentPageIndex = widget.index;
//     pageViewController = PageController(initialPage: widget.index);
//
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     pageViewController?.dispose();
//     flutterStoryController.dispose();
//     SmartDialog.dismiss();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             radius: 16.0,
//             backgroundImage: ExtendedNetworkImageProvider(
//               widget.memories?[currentPageIndex].user?.profilePicture ??
//                   MockData.imageAvatar,
//               cache: true,
//             ),
//           ),
//         ),
//         title: Text(
//           widget.memories?[currentPageIndex].user?.username ?? '',
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           Text(
//             GetTimeAgo.parse(
//               widget.memories![currentPageIndex]
//                   .userMemories![currentMemoryIndex].createdAt!,
//             ),
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 12.0,
//             ),
//           ),
//           Gap(8),
//         ],
//       ),
//       body: PageView.builder(
//           controller: pageViewController,
//           itemCount: widget.memories?.length ?? 0,
//           onPageChanged: (index) {
//             currentPageIndex = index;
//             setState(() {});
//           },
//           itemBuilder: (context, index) {
//             List<UserMemory> userMemories =
//                 widget.memories?[index].userMemories ?? [];
//             return StoryView(
//               onVerticalSwipeComplete: (direction) {
//                 if (direction == Direction.down || direction == Direction.up) {
//                   Navigator.pop(context);
//                 }
//               },
//               storyItems: [
//                 for (int i = 0; i < (userMemories.length); i++)
//                   userMemories[i].isImage == true
//                       ? StoryItem.pageImage(
//                     controller: flutterStoryController,
//                     url:
//                     '${widget.memories?[index].userMemories?[i].imageUrl}',
//                     duration: baseDuration,
//                   )
//                       : userMemories[i].isVideo == true
//                       ? StoryItem.pageVideo(
//                     generateOptimizedCloudinaryVideoUrl(
//                         originalUrl:
//                         '${widget.memories?[index].userMemories?[i].videoUrl}'),
//                     controller: flutterStoryController,
//                     duration: Duration(
//                         milliseconds: widget.memories?[index]
//                             .userMemories?[i].videoDurationMs ??
//                             0),
//                     caption: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           '${widget.memories?[index].userMemories?[i].caption}',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0,
//                           ),
//                         ),
//                         Gap(50),
//                       ],
//                     ),
//                   )
//                       : StoryItem.text(
//                     title:
//                     'Unable to load content (Not an image or video)',
//                     textStyle: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.0,
//                     ),
//                     backgroundColor: Colors.black,
//                     duration: baseDuration,
//                   ),
//               ],
//               controller: flutterStoryController,
//               onStoryShow: (storyItem, index) {
//                 currentMemoryIndex = index;
//                 if ((userMemories[index].ctaAction?.isNotEmpty ?? false) &&
//                     (userMemories[index].ctaActionUrl?.isNotEmpty ?? false)) {
//                   SmartDialog.show(
//                     maskColor: Colors.transparent,
//                     keepSingle: true,
//                     clickMaskDismiss: false,
//                     usePenetrate: true,
//                     alignment: Alignment.bottomCenter,
//                     builder: (context) {
//                       return Container(
//                         color: Colors.white,
//                         padding: const EdgeInsets.all(4.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: WhatsevrButton.filled(
//                                 label: userMemories[index].ctaAction ??
//                                     'Open Link',
//                                 onPressed: () {
//                                   launchWebURL(context,
//                                       url: userMemories[index].ctaActionUrl ??
//                                           '');
//                                 },
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 flutterStoryController.pause();
//                                 showAppModalSheet(
//                                     child: LinksPreviewListView(
//                                       urls: [
//                                         userMemories[index].ctaActionUrl ?? ''
//                                       ],
//                                     ));
//                               },
//                               icon: const Icon(Icons.info_outline),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   SmartDialog.dismiss();
//                 }
//               },
//               repeat: widget.memories?.length == 1,
//               onComplete: () async {
//                 if (index < (widget.memories?.length ?? 0) - 1) {
//                   pageViewController?.nextPage(
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.easeInOut,
//                   );
//                 }
//               },
//             );
//           }),
//     );
//   }
// }
