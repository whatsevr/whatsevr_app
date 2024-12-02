import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/join_leave_community.dart';
import 'package:whatsevr_app/config/widgets/dialogs/community_members.dart';
import 'package:whatsevr_app/src/features/community/views/widgets/offers.dart';

import 'package:whatsevr_app/config/api/response_model/user_memories.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/dialogs/content_upload_button_sheet.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/previewers/photo.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/utils/conversion.dart';
import 'package:whatsevr_app/src/features/details/memory/views/memories.dart';

import 'package:whatsevr_app/src/features/community/bloc/bloc.dart';
import 'package:whatsevr_app/src/features/community/views/widgets/about.dart';
import 'package:whatsevr_app/src/features/community/views/widgets/cover_media.dart';

import 'package:whatsevr_app/src/features/community/views/widgets/services.dart';
import 'package:whatsevr_app/src/features/community/views/widgets/videos.dart';

class CommunityPageArgument {
  final bool isEditMode;
  final String? communityUid;

  CommunityPageArgument({this.isEditMode = false, required this.communityUid});
}

class CommunityPage extends StatelessWidget {
  final CommunityPageArgument? pageArgument;

  const CommunityPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CommunityBloc()
        ..add(
          InitialEvent(
            communityPageArgument: pageArgument,
          ),
        ),
      child: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (BuildContext context, CommunityState state) {
          return Scaffold(
            body: MyRefreshIndicator(
              onPullDown: () async {
                context.read<CommunityBloc>().add(LoadCommunityData());
                await Future<void>.delayed(const Duration(seconds: 2));
              },
              child: ContentMask(
                showMask: state.communityDetailsResponse == null,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Stack(
                      children: [
                        CommunityPageCoverVideoView(),
                        //avatar
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: GestureDetector(
                            onTap: () {
                              if (state.communityMemories.isEmpty) {
                                return;
                              }
                              showAppModalSheet(
                                flexibleSheet: false,
                                child: SizedBox(
                                  height: 220,
                                  child: ListView.separated(
                                    itemCount: state.communityMemories.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      final Memory? memory =
                                          state.communityMemories[index];
                                      return GestureDetector(
                                        onTap: () {
                                          showMemoriesPlayer(
                                            context,
                                            uiMemoryGroups: [
                                              UiMemoryGroup(
                                                userUid: state
                                                    .communityDetailsResponse
                                                    ?.communityInfo
                                                    ?.uid,
                                                username: state
                                                    .communityDetailsResponse
                                                    ?.communityInfo
                                                    ?.username,
                                                profilePicture: state
                                                    .communityDetailsResponse
                                                    ?.communityInfo
                                                    ?.profilePicture,
                                                uiMemoryGroupItems: [
                                                  for (Memory? memory in state
                                                      .communityMemories)
                                                    UiMemoryGroupItems(
                                                      isImage: memory?.isImage,
                                                      imageUrl:
                                                          memory?.imageUrl,
                                                      isVideo: memory?.isVideo,
                                                      videoUrl:
                                                          memory?.videoUrl,
                                                      videoDurationMs: memory
                                                          ?.videoDurationMs,
                                                      ctaAction:
                                                          memory?.ctaAction,
                                                      ctaActionUrl:
                                                          memory?.ctaActionUrl,
                                                      caption: memory?.caption,
                                                      createdAt:
                                                          memory?.createdAt,
                                                    ),
                                                ],
                                              ),
                                            ],
                                            startGroupIndex: 0,
                                            startMemoryIndex: index,
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              GetTimeAgo.parse(
                                                memory!.createdAt!,
                                              ),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Gap(8),
                                            Expanded(
                                              child: Container(
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  image: DecorationImage(
                                                    image:
                                                        ExtendedNetworkImageProvider(
                                                      '${memory.imageUrl}',
                                                      cache: true,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(8),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.remove_red_eye,
                                                  size: 16,
                                                ),
                                                const Gap(4),
                                                Text(
                                                  '${formatCountToKMBTQ(memory.totalViews)}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(8),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return const Gap(8);
                                    },
                                  ),
                                ),
                              );
                            },
                            onLongPress: () {
                              showPhotoPreviewDialog(
                                context: context,
                                photoUrl:
                                    '${state.communityDetailsResponse?.communityInfo?.profilePicture}',
                                appBarTitle:
                                    '${state.communityDetailsResponse?.communityInfo?.username}',
                              );
                            },
                            child: AdvancedAvatar(
                              size: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: state.communityMemories.isEmpty
                                      ? Colors.white
                                      : Colors.blue,
                                  width: 3.0,
                                ),
                              ),
                              child: Padding(
                                padding: state.communityMemories.isEmpty
                                    ? EdgeInsets.zero
                                    : const EdgeInsets.all(2),
                                child: ExtendedImage.network(
                                  state.communityDetailsResponse?.communityInfo
                                          ?.profilePicture ??
                                      MockData.blankProfileAvatar,
                                  shape: BoxShape.circle,
                                  fit: BoxFit.cover,
                                  enableLoadState: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...[
                      const Gap(8),
                      PadHorizontal(
                        child: Text(
                          '${state.communityDetailsResponse?.communityInfo?.title}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    const Gap(4),
                    Builder(
                      builder: (context) {
                        return PadHorizontal(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      ' @${state.communityDetailsResponse?.communityInfo?.username}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Gap(8),
                                  ],
                                ),
                              ),
                              Gap(12),
                              if (pageArgument?.isEditMode == true) ...<Widget>[
                                IconButton(
                                  icon: const Iconify(
                                    Ri.heart_add_fill,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showContentUploadBottomSheet(
                                      context,
                                      postCreatorType:
                                          EnumPostCreatorType.COMMUNITY,
                                      communityUid: state
                                          .communityDetailsResponse
                                          ?.communityInfo
                                          ?.uid,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.menu),
                                  onPressed: () {
                                    showAppModalSheet(
                                      flexibleSheet: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.edit),
                                            title: const Text(
                                              'Manage Community',
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              // await AppNavigationService
                                              //     .newRoute(
                                              //   RoutesName.updateProfile,
                                              //   extras:
                                              //       ProfileUpdatePageArgument(
                                              //     profileDetailsResponse: state
                                              //         .communityDetailsResponse,
                                              //   ),
                                              // );
                                              // context.read<CommunityBloc>().add(
                                              //       LoadCommunityData(),
                                              //     );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                    const Gap(28),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showCommunityMembersDialog(
                          context: context,
                          communityUid: (state
                              .communityDetailsResponse?.communityInfo?.uid)!,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PadHorizontal.paddingValue,
                          vertical: 8,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.whatsevrTheme.shadow,
                        ),
                        child: Text(
                          '${formatCountToKMBTQ(state.communityDetailsResponse?.communityInfo?.totalMembers)} Members',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Gap(8),
                    if (pageArgument?.isEditMode != true) ...<Widget>[
                      PadHorizontal(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.blue,
                                onPressed: () {},
                                child: const Text(
                                  'Chat',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: WhatsevrCommunityJoinLeaveButton(
                                communityUid: state.communityDetailsResponse
                                    ?.communityInfo?.uid,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const PadHorizontal(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Suggestions',
                              style: TextStyle(fontSize: 14),
                            ),
                            Spacer(),
                            Text(
                              'See All',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 8 : 0,
                                      right: 8,
                                    ),
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Gap(8),
                                        Expanded(
                                          child: ExtendedImage.network(
                                            MockData.randomImageAvatar(),
                                            shape: BoxShape.circle,
                                            fit: BoxFit.cover,
                                            enableLoadState: false,
                                          ),
                                        ),
                                        const Gap(8),
                                        const Text(
                                          'John Doe',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minWidth: 150,
                                  color: Colors.blue,
                                  onPressed: () {},
                                  child: const Text('Join'),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(8);
                          },
                          itemCount: 10,
                        ),
                      ),
                      const Gap(8),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PadHorizontal.paddingValue,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: const Column(
                        children: <Widget>[
                          Gap(12),
                          WhatsevrTabBarWithViews(
                            shrinkViews: true,
                            tabAlignment: TabAlignment.start,
                            isTabsScrollable: true,
                            tabViews: [
                              ('About', CommunityPageAboutView()),
                              ('Services', CommunityPageServicesView()),
                              ('Media', Text('Media')),
                              ('Videos', CommunityPageVideosView()),
                              ('Offers', CommunityPageOffersView()),
                            ],  
                          ),
                          Gap(50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
