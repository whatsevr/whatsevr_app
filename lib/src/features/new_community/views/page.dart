import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/response_model/community/top_communities.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/content_mask.dart';
import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';
import 'package:whatsevr_app/config/widgets/two_state_ui.dart';
import 'package:whatsevr_app/src/features/new_community/bloc/new_community_bloc.dart';

import '../../../../config/widgets/choice_chip.dart';

class NewCommunityPageArgument {
  NewCommunityPageArgument();
}

class NewCommunityPage extends StatelessWidget {
  final NewCommunityPageArgument pageArgument;
  const NewCommunityPage({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCommunityBloc()
        ..add(NewCommunityInitialEvent(pageArgument: pageArgument)),
      child: Builder(builder: (context) {
        return buildPage(context);
      }),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<NewCommunityBloc, NewCommunityState>(
      builder: (context, state) {
        return Scaffold(
          appBar: WhatsevrAppBar(title: 'New Community'),
          body: ListView(
            padding: PadHorizontal.padding,
            children: [
              Gap(12),
              Text('Top Communities', style: TextStyle(fontSize: 18)),
              Gap(12),
              ContentMask(
                showMask: state.topCommunities?.isEmpty ?? true,
                child: MasonryGridView.count(
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
                            backgroundImage:
                                NetworkImage(community?.profilePicture ?? ''),
                            radius: 20,
                          ),
                          Gap(4),
                          Column(
                            children: [
                              Text(
                                community?.title ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(4),
                              Text(
                                community?.username ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Gap(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people,
                                  size: 16, color: Colors.grey[600]),
                              SizedBox(width: 4),
                              Text(
                                '${community?.totalMembers ?? 0} members',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info,
                                  size: 16, color: Colors.grey[600]),
                              SizedBox(width: 4),
                              Text(
                                community?.status ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Gap(4),
                          WhatsevrTwoStateUi(
                            isFirstState: true,
                            firstStateUi: WhatsevrButton.outlined(
                              miniButton: true,
                              label: 'Join',
                              onPressed: () {},
                            ),
                            secondStateUi: WhatsevrButton.outlined(
                              miniButton: true,
                              label: 'Joined',
                              onPressed: () {},
                            ),
                            onStateChanged: (isFirstState, isSecondState) {},
                          )
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
                    child: Column(
                  children: [
                    WhatsevrFormField.generalTextField(
                      headingTitle: 'Community Name',
                    ),
                    Gap(12),
                    WhatsevrFormField.invokeCustomFunction(
                      context: context,
                      readOnly: false,
                      headingTitle: 'Status',
                      customFunction: () {},
                    ),
                    Gap(12),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Users can only join'),
                        ),
                        WhatsevrChoiceChip(
                          label: "After Approval",
                          selected: true,
                          onSelected: (value) {},
                        ),
                      ],
                    ),
                    Gap(12),
                    WhatsevrButton.filled(
                      label: 'Create',
                      onPressed: () {},
                    ),
                  ],
                ));
              },
            ),
          ),
        );
      },
    );
  }
}
