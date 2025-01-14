import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsevr_app/config/api/external/models/memory.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/buttons/follow_unfollow.dart';
import 'package:whatsevr_app/config/widgets/dialogs/start_chat.dart';
import 'package:whatsevr_app/config/widgets/dialogs/user_relations.dart';
import 'package:whatsevr_app/config/api/response_model/post/memories.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/dialogs/content_upload_button_sheet.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/post_tiles/dynamic_mix_post_tile.dart';
import 'package:whatsevr_app/config/widgets/previewers/photo.dart';
import 'package:whatsevr_app/config/widgets/refresh_indicator.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/widgets/textfield/animated_search_field.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';
import 'package:whatsevr_app/utils/conversion.dart';
import 'package:whatsevr_app/src/features/details/memory/views/memories.dart';

import 'package:whatsevr_app/src/features/settings/views/page.dart';
import 'package:whatsevr_app/src/features/account/bloc/account_bloc.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/about.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/cover_media.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/flicks.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/offers.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/pdfs.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/services.dart';
import 'package:whatsevr_app/src/features/account/views/widgets/videos.dart';

part 'widgets/mix_content.dart';
part 'widgets/tagged_content.dart';

class AccountPageArgument {
  final bool isEditMode;
  final String? userUid;

  AccountPageArgument({this.isEditMode = false, required this.userUid});
}

class AccountPage extends StatelessWidget {
  final AccountPageArgument? pageArgument;

  const AccountPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.whatsevrTheme;
    return BlocProvider(
      create: (BuildContext context) => AccountBloc()
        ..add(
          AccountInitialEvent(
            accountPageArgument: pageArgument,
          ),
        ),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (BuildContext context, AccountState state) {
          return Scaffold(
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
                        RoutesName.allSearch,
                      );
                    },
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: MyRefreshIndicator(
                    onPullDown: () async {
                      context.read<AccountBloc>().add(LoadAccountData());
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
                              true)
                            Container(
                              decoration: BoxDecoration(
                                color: theme.surface,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 10,
                              ),
                              child: Text(
                                '${state.profileDetailsResponse?.userInfo?.portfolioTitle}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const Gap(18),
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
                                        icon: const Icon(
                                          WhatsevrIcons.postUploadIcon002,
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
                                        icon: Icon(WhatsevrIcons.hamburgerIcon),
                                        onPressed: () {
                                          AppNavigationService.newRoute(
                                            RoutesName.settings,
                                            extras: SettingsPageArgument(),
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
                                        isPortfolio: state
                                            .profileDetailsResponse
                                            ?.userInfo
                                            ?.isPortfolio,
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
                                          'Followers',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
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
                                        isPortfolio: state
                                            .profileDetailsResponse
                                            ?.userInfo
                                            ?.isPortfolio,
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
                                          state.profileDetailsResponse?.userInfo
                                                      ?.isPortfolio ==
                                                  true
                                              ? 'Connections'
                                              : 'Friends',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          if (pageArgument?.isEditMode != true &&
                              pageArgument?.userUid !=
                                  AuthUserDb.getLastLoggedUserUid())
                            PadHorizontal(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: WhatsevrButton.filled(
                                      miniButton: true,
                                      label: 'Message',
                                      onPressed: () {
                                        startChatHelper(
                                          senderUserUid:
                                              AuthUserDb.getLastLoggedUserUid(),
                                          otherUserUid: state
                                              .profileDetailsResponse
                                              ?.userInfo
                                              ?.uid,
                                        );
                                      },
                                    ),
                                  ),
                                  const Gap(8),
                                  Expanded(
                                    child: WhatsevrFollowButton(
                                      followeeUserUid: state
                                          .profileDetailsResponse
                                          ?.userInfo
                                          ?.uid,
                                    ),
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
                            child: Column(
                              children: <Widget>[
                                const Gap(12),
                                WhatsevrTabBarWithViews(
                                  shrinkViews: true,
                                  tabAlignment: TabAlignment.start,
                                  isTabsScrollable: true,
                                  spaceBetween: 2,
                                  tabViews: [
                                    ('About', AccountPageAboutView()),
                                    if (state.profileDetailsResponse?.userInfo
                                            ?.isPortfolio ==
                                        true)
                                      ('Services', AccountPageServicesView()),
                                    ('Media', _MixContentView()),
                                    (
                                      state.profileDetailsResponse?.userInfo
                                                  ?.isPortfolio ==
                                              true
                                          ? 'Wtv'
                                          : 'Videos',
                                      AccountPageVideosView()
                                    ),
                                    ('Flicks', AccountPageFlicksView()),
                                    ('Offerings', AccountPageOffersView()),
                                    if (state.profileDetailsResponse?.userInfo
                                            ?.isPortfolio ==
                                        true)
                                      ('Pdf', AccountPagePdfsView()),
                                    ('Tags', _TaggedContentView()),
                                  ],
                                ),
                                const Gap(50),
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
