import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/methods/community.dart';
import 'package:whatsevr_app/config/api/response_model/community/community_members.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/api/methods/user_relations.dart';

import 'package:whatsevr_app/config/widgets/buttons/follow_unfollow.dart';

void showCommunityMembersDialog({
  required BuildContext context,
  required String communityUid,
}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return _Ui(userUid: communityUid);
    },
  );
}

class _Ui extends StatefulWidget {
  final String userUid;

  const _Ui({super.key, required this.userUid});

  @override
  _UiState createState() => _UiState();
}

class _UiState extends State<_Ui>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhatsevrAppBar(
        title: 'Participants',
      ),
      body: WhatsevrTabBarWithViews(
        isTabsScrollable: true,
        tabAlignment: TabAlignment.start,
        tabViews: [
          ('Members', _MembersView(userUid: widget.userUid)),
        
          
        ],
      ),
    );
  }
}

class _MemberInfo extends StatelessWidget {
  final bool isCard;
  final Member user;
  final VoidCallback onTap;

  const _MemberInfo({
    super.key,
    this.isCard = false,
    required this.user,
    required this.onTap,
  });

  Widget followButton() {
    return WhatsevrFollowButton(
      followeeUserUid: user.uid!,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCard) {
      return Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: ExtendedNetworkImageProvider(
                  user.profilePicture ?? MockData.blankProfileAvatar,
                ),
                radius: 30,
              ),
              const SizedBox(height: 8),
              Text(
                user.name ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              followButton(),
            ],
          ),
        ),
      );
    }
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: ExtendedNetworkImageProvider(
          user.profilePicture ?? MockData.blankProfileAvatar,
        ),
      ),
      title: Text(user.name ?? 'Unknown'),
      subtitle: Text(
        user.username ?? 'Unknown',
        style: const TextStyle(fontSize: 12),
      ),
      trailing: followButton(),
    );
  }
}

class _MembersView extends StatefulWidget {
  final String userUid;

  const _MembersView({super.key, required this.userUid});

  @override
  _MembersViewState createState() => _MembersViewState();
}

class _MembersViewState extends State<_MembersView> {
  bool _isLoading = true;
  List<Datum> _followers = [];
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLastPage = false;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchMembers();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (!_isLastPage && !_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
      });

      final CommunityMembersResponse? response = await CommunityApi.getCommunityMembers(
        communityUid: widget.userUid,
        page: _currentPage + 1,
      );

      if (response?.data != null) {
        setState(() {
          _followers.addAll(response!.data!);
          _currentPage++;
          _isLastPage = response.lastPage ?? false;
          _isFetchingMore = false;
        });
      }
    }
  }

  Future<void> _fetchMembers() async {
    final CommunityMembersResponse? response = await CommunityApi.getCommunityMembers(
      communityUid: widget.userUid,
      page: _currentPage,
    );

    setState(() {
      _followers = response?.data ?? [];
      _isLastPage = response?.lastPage ?? false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _followers.isEmpty
            ? const Center(child: Text('No Followers'))
            : ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(8.0),
                separatorBuilder: (context, index) => Gap(8.0),
                itemCount: _followers.length + (_isLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index == _followers.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return _MemberInfo(
                    user: _followers[index].user!,
                    onTap: () {
                      // Handle follow action
                    },
                  );
                },
              );
  }
}
