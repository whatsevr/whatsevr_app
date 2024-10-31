import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:whatsevr_app/config/widgets/dialogs/user_relations.dart';

import '../../../../config/api/response_model/user_memories.dart';
import '../../../../config/enums/post_creator_type.dart';
import '../../../../config/mocks/mocks.dart';
import '../../../../config/routes/router.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../config/widgets/content_mask.dart';
import '../../../../config/widgets/dialogs/content_upload_button_sheet.dart';
import '../../../../config/widgets/dialogs/showAppModalSheet.dart';
import '../../../../config/widgets/pad_horizontal.dart';
import '../../../../config/widgets/previewers/photo.dart';
import '../../../../config/widgets/refresh_indicator.dart';
import '../../../../config/widgets/tab_bar.dart';
import '../../../../config/widgets/textfield/animated_search_field.dart';
import '../../../../utils/conversion.dart';
import '../../details/memory/views/memories.dart';
import '../../search_pages/account/views/page.dart';
import '../../settings/views/page.dart';
import '../../update_profile/views/page.dart';
import '../bloc/account_bloc.dart';
import 'widgets/about.dart';
import 'widgets/cover_media.dart';
import 'widgets/flicks.dart';
import 'widgets/offers.dart';
import 'widgets/pdfs.dart';
import 'widgets/services.dart';
import 'widgets/videos.dart';

class AccountPageArgument {
  final bool isEditMode;
  final String? userUid;

  AccountPageArgument({required this.isEditMode, this.userUid});
}

class AccountPage extends StatelessWidget {
  final AccountPageArgument? pageArgument;

  const AccountPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AccountBloc()..add(AccountInitialEvent()),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (BuildContext context, AccountState state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                PadHorizontal(
                  child: WhatsevrAnimatedSearchField(
                    hintTexts: const <String>[
                      'Search for Account',
                      'Search for Portfolio',
                      'Search for Community',
                    ],
                    readOnly: true,
                    onTap: () {
                      AppNavigationService.newRoute(
                        RoutesName.accountSearch,
                        extras: const AccountSearchPage(
                          hintTexts: <String>[
                            'Search for Account',
                            'Search for Portfolio',
                            'Search for Community',
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: MyRefreshIndicator(
                    onPullDown: () async {
                      context.read<AccountBloc>().add(AccountInitialEvent());
                      await Future<void>.delayed(const Duration(seconds: 2));
                    },
                    child: ContentMask(
                      showMask: state.profileDetailsResponse == null,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          AccountPageCoverVideoView(),
                          if (state.profileDetailsResponse?.userInfo
                                  ?.isPortfolio ==
                              true) ...[
                            const Gap(8),
                            PadHorizontal(
                              child: Text(
                                '${state.profileDetailsResponse?.userInfo?.portfolioTitle}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          const Gap(8),
                          Builder(
                            builder: (context) {
                              return PadHorizontal(
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if (state.userMemories.isEmpty) {
                                          return;
                                        }
                                        showAppModalSheet(
                                          flexibleSheet: false,
                                          child: SizedBox(
                                            height: 220,
                                            child: ListView.separated(
                                              itemCount:
                                                  state.userMemories.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (
                                                BuildContext context,
                                                int index,
                                              ) {
                                                final Memory? memory =
                                                    state.userMemories[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    showMemoriesPlayer(
                                                      context,
                                                      uiMemoryGroups: [
                                                        UiMemoryGroup(
                                                          userUid: state
                                                              .profileDetailsResponse
                                                              ?.userInfo
                                                              ?.uid,
                                                          username: state
                                                              .profileDetailsResponse
                                                              ?.userInfo
                                                              ?.username,
                                                          profilePicture: state
                                                              .profileDetailsResponse
                                                              ?.userInfo
                                                              ?.profilePicture,
                                                          uiMemoryGroupItems: [
                                                            for (Memory? memory
                                                                in state
                                                                    .userMemories)
                                                              UiMemoryGroupItems(
                                                                isImage: memory
                                                                    ?.isImage,
                                                                imageUrl: memory
                                                                    ?.imageUrl,
                                                                isVideo: memory
                                                                    ?.isVideo,
                                                                videoUrl: memory
                                                                    ?.videoUrl,
                                                                videoDurationMs:
                                                                    memory
                                                                        ?.videoDurationMs,
                                                                ctaAction: memory
                                                                    ?.ctaAction,
                                                                ctaActionUrl: memory
                                                                    ?.ctaActionUrl,
                                                                caption: memory
                                                                    ?.caption,
                                                                createdAt: memory
                                                                    ?.createdAt,
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
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              8,
                                                            ),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            image:
                                                                DecorationImage(
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
                                                            Icons
                                                                .remove_red_eye,
                                                            size: 16,
                                                          ),
                                                          const Gap(4),
                                                          Text(
                                                            '${formatCountToKMBTQ(memory.totalViews)}',
                                                            style:
                                                                const TextStyle(
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
                                              '${state.profileDetailsResponse?.userInfo?.profilePicture}',
                                          appBarTitle:
                                              '${state.profileDetailsResponse?.userInfo?.username}',
                                        );
                                      },
                                      child: AdvancedAvatar(
                                        size: 55,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: state.userMemories.isEmpty
                                              ? null
                                              : Border.all(
                                                  color: Colors.blue,
                                                  width: 3.0,
                                                ),
                                        ),
                                        child: Padding(
                                          padding: state.userMemories.isEmpty
                                              ? EdgeInsets.zero
                                              : const EdgeInsets.all(2),
                                          child: ExtendedImage.network(
                                            state
                                                    .profileDetailsResponse
                                                    ?.userInfo
                                                    ?.profilePicture ??
                                                MockData.blankProfileAvatar,
                                            shape: BoxShape.circle,
                                            fit: BoxFit.cover,
                                            enableLoadState: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${state.profileDetailsResponse?.userInfo?.name}',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            ' @${state.profileDetailsResponse?.userInfo?.username}',
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
                                    if (pageArgument?.isEditMode ==
                                        true) ...<Widget>[
                                      IconButton(
                                        icon: const Iconify(
                                          Ri.heart_add_fill,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          showContentUploadBottomSheet(
                                            context,
                                            postCreatorType: state
                                                        .profileDetailsResponse
                                                        ?.userInfo
                                                        ?.isPortfolio ==
                                                    true
                                                ? EnumPostCreatorType.PORTFOLIO
                                                : EnumPostCreatorType.ACCOUNT,
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
                                                  leading:
                                                      const Icon(Icons.edit),
                                                  title: const Text(
                                                    'Edit Profile',
                                                  ),
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await AppNavigationService
                                                        .newRoute(
                                                      RoutesName.updateProfile,
                                                      extras:
                                                          ProfileUpdatePageArgument(
                                                        profileDetailsResponse:
                                                            state
                                                                .profileDetailsResponse,
                                                      ),
                                                    );
                                                    context
                                                        .read<AccountBloc>()
                                                        .add(
                                                          AccountInitialEvent(),
                                                        );
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                    Icons.settings,
                                                  ),
                                                  title: const Text(
                                                    'Manage Account',
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    AppNavigationService
                                                        .newRoute(
                                                      RoutesName.settings,
                                                      extras:
                                                          SettingsPageArgument(),
                                                    );
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
                          PadHorizontal(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${formatCountToKMBTQ(state.profileDetailsResponse?.userInfo?.totalLikes)}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'Likes',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        showUserRelationsDialog(
                                          context: context,
                                          userUid: (state.profileDetailsResponse
                                              ?.userInfo?.uid)!,
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${formatCountToKMBTQ(state.profileDetailsResponse?.userInfo?.totalFollowers)}',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            'Networks',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        showUserRelationsDialog(
                                          context: context,
                                          userUid: (state.profileDetailsResponse
                                              ?.userInfo?.uid)!,
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${formatCountToKMBTQ(state.profileDetailsResponse?.userInfo?.totalConnections)}',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            'Connections',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          if (pageArgument?.isEditMode != true) ...<Widget>[
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.black),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        minWidth: 150,
                                        color: Colors.blue,
                                        onPressed: () {},
                                        child: const Text('Follow'),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
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
                                    ('About', AccountPageAboutView()),
                                    ('Services', AccountPageServicesView()),
                                    ('Media', Text('Media')),
                                    ('Videos', AccountPageVideosView()),
                                    ('Flicks', AccountPageFlicksView()),
                                    ('Offerings', AccountPageOffersView()),
                                    ('Pdf', AccountPagePdfsView()),
                                    ('Tags', Text('Tags')),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
