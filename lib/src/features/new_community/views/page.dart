import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/api/response_model/community/top_communities.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/buttons/choice_chip.dart';
import 'package:whatsevr_app/config/widgets/buttons/join_leave_community.dart';
import 'package:whatsevr_app/config/widgets/buttons/two_state_ui.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/dialogs/common_data_list.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/textfield/super_textform_field.dart';
import 'package:whatsevr_app/src/features/new_community/bloc/new_community_bloc.dart';

class NewCommunityPageArgument {
  NewCommunityPageArgument();
}

class NewCommunityPage extends StatelessWidget {
  final NewCommunityPageArgument pageArgument;
  NewCommunityPage({super.key, required this.pageArgument});
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCommunityBloc()
        ..add(NewCommunityInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<NewCommunityBloc, NewCommunityState>(
      builder: (context, state) {
        onReachingEndOfTheList(
          context,
          scrollController: scrollController,
          execute: () {
            context.read<NewCommunityBloc>().add(
                  LoadMoreTopCommunitiesEvent(
                    page: state.topCommunitiesPaginationData!.currentPage + 1,
                  ),
                );
          },
        );
        return Scaffold(
          appBar: WhatsevrAppBar(title: 'New Community'),
          body: ListView(
            padding: PadHorizontal.padding,
            children: [
              Gap(12),
              Text(
                'Top Communities',
                style: TextStyle(fontSize: 18),
              ),
              Gap(12),
              ContentMask(
                showMask: state.topCommunities?.isEmpty ?? true,
                child: MasonryGridView.count(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemCount: state.topCommunities?.length ?? 0,
                  itemBuilder: (context, index) {
                    final TopCommunity? community =
                        state.topCommunities?[index];
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: ExtendedNetworkImageProvider(
                              community?.profilePicture ??
                                  MockData.blankCommunityAvatar,
                            ),
                            radius: 20,
                          ),
                          Gap(4),
                          Text(
                            community?.title ?? '',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${community?.totalMembers ?? 0} members',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lightbulb,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  community?.status ?? 'Unknown',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(4),
                          WhatsevrCommunityJoinLeaveButton(
                            communityUid: community?.uid,
                            
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Gap(12),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: WhatsevrButton.filled(
              label: 'Create A New Community',
              onPressed: () {
                showAppModalSheet(
                  child: BlocProvider.value(
                    value: context.read<NewCommunityBloc>(),
                    child: BlocBuilder<NewCommunityBloc, NewCommunityState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            WhatsevrFormField.multilineTextField(
                              controller: context
                                  .read<NewCommunityBloc>()
                                  .communityNameController,
                              headingTitle: 'Community Name',
                              minLines: 4,
                              maxLines: 4,
                              maxLength: 40,
                              hintText:
                                  'Hint; In crafting titles, balance clarity, engagement, and focus to attract users and build vibrant, purpose-driven communities.',
                            ),
                            Gap(12),
                            WhatsevrFormField.invokeCustomFunction(
                              controller: context
                                  .read<NewCommunityBloc>()
                                  .communityStatusController,
                              readOnly: false,
                              headingTitle: 'Status',
                              hintText:
                                  'Hint; Short innovative or volatile keyword',
                              customFunction: () {
                                showAppModalSheet(
                                  child: CommonDataSearchSelectPage(
                                    showProfessionalStatus: true,
                                    onProfessionalStatusSelected:
                                        (professionalStatus) {
                                      context
                                              .read<NewCommunityBloc>()
                                              .communityStatusController
                                              .text =
                                          professionalStatus.title ?? '';
                                    },
                                  ),
                                );
                              },
                            ),
                            Gap(12),
                            Row(
                              children: [
                                Expanded(
                                  child:
                                      Text('Require admin approval to join?'),
                                ),
                                WhatsevrChoiceChip(
                                  label: 'Yes',
                                  choiced: state.approveJoiningRequest ?? false,
                                  switchChoice: (value) {
                                    context.read<NewCommunityBloc>().add(
                                          ChangeApproveJoiningRequestEvent(),
                                        );
                                  },
                                ),
                                Gap(4),
                                WhatsevrChoiceChip(
                                  label: 'No',
                                  choiced:
                                      !(state.approveJoiningRequest ?? false),
                                  switchChoice: (value) {
                                    context.read<NewCommunityBloc>().add(
                                          ChangeApproveJoiningRequestEvent(),
                                        );
                                  },
                                ),
                              ],
                            ),
                            Gap(12),
                            WhatsevrButton.filled(
                              label: 'Create',
                              onPressed: () {
                                context.read<NewCommunityBloc>().add(
                                  CreateCommunityEvent(
                                    onCompleted: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
