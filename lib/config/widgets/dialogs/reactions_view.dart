import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';

import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/reactions.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/reactions/get_reactions.dart'
    as m1;
import 'package:whatsevr_app/config/api/response_model/user_details.dart';
import 'package:whatsevr_app/config/enums/reaction_type.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/buttons/choice_chip.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/previewers/photo.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';

void showReactionsDialog({
  String? videoPostUid,
  String? photoPostUid,
  String? pdfUid,
  String? memoryUid,
  String? offerPostUid,
  String? flickPostUid,
}) {
  final int nonNullCount = [
    videoPostUid,
    photoPostUid,
    pdfUid,
    memoryUid,
    offerPostUid,
    flickPostUid,
  ].where((element) => element != null).length;

  if (nonNullCount != 1) {
    throw ArgumentError('Only one parameter should be non-null');
  }
  showAppModalSheet(
    transparentMask: true,
    flexibleSheet: false,
    resizeToAvoidBottomInset: false,
    maxSheetHeight: 0.8,
    child: _Ui(
      videoPostUid: videoPostUid,
      photoPostUid: photoPostUid,
      pdfUid: pdfUid,
      memoryUid: memoryUid,
      offerPostUid: offerPostUid,
      flickPostUid: flickPostUid,
    ),
  );
}

class _Ui extends StatefulWidget {
  final String? videoPostUid;
  final String? photoPostUid;
  final String? pdfUid;
  final String? memoryUid;
  final String? offerPostUid;
  final String? flickPostUid;

  const _Ui({
    this.videoPostUid,
    this.photoPostUid,
    this.pdfUid,
    this.memoryUid,
    this.offerPostUid,
    this.flickPostUid,
  });

  @override
  State<_Ui> createState() => _UiState();
}

class _UiState extends State<_Ui> {
  List<m1.Reaction> _reactions = [];

  final FocusNode _focusNode = FocusNode();
  PaginationData? reactionsPaginationData = PaginationData();
  m1.Reaction? replyingToTheComment;
  ReactionType? selectedReactionType;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCurrentUserDetails();
    getReactions(1);
    onReachingEndOfTheList(
      context,
      scrollController: scrollController,
      execute: () {
        getReactions((reactionsPaginationData?.currentPage ?? 0) + 1);
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();

    scrollController.dispose();
    super.dispose();
  }

  UserDetailsResponse? currentUserDetails;

  void getCurrentUserDetails() async {
    final String? userUid = AuthUserDb.getLastLoggedUserUid();
    currentUserDetails = await UsersApi.getUserDetails(userUid: userUid!);
  }

  void getReactions(int page) async {
    if (reactionsPaginationData?.noMoreData == true ||
        reactionsPaginationData?.isLoading == true) {
      return;
    }
    reactionsPaginationData =
        reactionsPaginationData?.copyWith(isLoading: true);
    final m1.GetReactionsResponse? response =
        await ReactionsApi.getContentReactions(
      page: page,
      videoPostUid: widget.videoPostUid,
      photoPostUid: widget.photoPostUid,
      pdfUid: widget.pdfUid,
      memoryUid: widget.memoryUid,
      offerPostUid: widget.offerPostUid,
      flickPostUid: widget.flickPostUid,
    );
    if (response != null) {
      setState(() {
        _reactions = [..._reactions, ...(response.reactions ?? [])];
        reactionsPaginationData = reactionsPaginationData?.copyWith(
          isLoading: false,
          currentPage: page,
          isLastPage: response.lastPage,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Gap(8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (ReactionType reactionType in ReactionType.values) ...[
                  WhatsevrChoiceChip(
                    choiced: selectedReactionType == reactionType,
                    switchChoice: (bool selected) {
                      if (_reactions.isEmpty) return;

                      setState(() {
                        selectedReactionType = selected ? reactionType : null;
                        // isTopComments = selected;
                        // if (isTopComments) {
                        //   _comments.sort((a, b) => a.user!.totalFollowers!
                        //       .compareTo(b.user!.totalFollowers!));
                        // } else {
                        //   _comments.sort(
                        //       (a, b) => a.createdAt!.compareTo(b.createdAt!));
                        // }
                        // _comments = _comments.reversed.toList();
                      });
                    },
                    label: reactionType.emoji,
                  ),
                  Gap(8),
                ],
              ],
            ),
          ),
          const Gap(8),
          Expanded(
            child: Builder(
              builder: (context) {
                if (_reactions.isEmpty) {
                  return const Center(
                    child: Text(
                      'Waiting for reactions...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: _reactions.length,
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final m1.Reaction reaction = _reactions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showPhotoPreviewDialog(
                                  context: context,
                                  photoUrl: reaction.user?.profilePicture,
                                  appBarTitle: reaction.user?.name,
                                );
                              },
                              child: Stack(
                                children: [
                                  ExtendedImage.network(
                                    reaction.user?.profilePicture ??
                                        MockData.blankProfileAvatar,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  //show the reaction
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 14,
                                        right: 8,
                                        top: 14,
                                        bottom: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: context.whatsevrTheme.divider,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                        ),
                                      ),
                                      child: Text(
                                        '${ReactionType.fromName(reaction.reactionType)?.emoji}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.whatsevrTheme.accent,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  reaction.user?.name ?? 'Anonymous',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  GetTimeAgo.parse(reaction.createdAt!) ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
