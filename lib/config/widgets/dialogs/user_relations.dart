import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/widgets/app_bar.dart';
import 'package:whatsevr_app/config/widgets/buttons/button.dart';
import 'package:whatsevr_app/config/widgets/dialogs/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/tab_bar.dart';
import 'package:whatsevr_app/config/api/methods/user_relations.dart';
import 'package:whatsevr_app/config/api/response_model/user_relations/user_relations.dart';

import 'package:whatsevr_app/config/widgets/buttons/follow_unfollow.dart';

void showUserRelationsDialog(
    {required BuildContext context, required String userUid,}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return _UserRelationsPage(userUid: userUid);
    },
  );
}

class _UserRelationsPage extends StatefulWidget {
  final String userUid;

  const _UserRelationsPage({super.key, required this.userUid});

  @override
  _UserRelationsPageState createState() => _UserRelationsPageState();
}

class _UserRelationsPageState extends State<_UserRelationsPage>
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
        title: 'Relations',
      ),
      body: WhatsevrTabBarWithViews(
        isTabsScrollable: true,
        tabAlignment: TabAlignment.start,
        tabViews: [
          ('Followers', FollowersTab(userUid: widget.userUid)),
          ('Following', FollowingTab(userUid: widget.userUid)),
          if (AuthUserDb.getLastLoggedUserUid() != widget.userUid)
            ('Mutual Followings', MutualFollowings(userUid: widget.userUid)),
          ('Connections', ConnectionsTab(userUid: widget.userUid)),
        ],
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final bool isCard;
  final User user;
  final VoidCallback onFollow;

  const _UserInfo({
    super.key,
    this.isCard = false,
    required this.user,
    required this.onFollow,
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
      subtitle: Text(user.username ?? 'Unknown',
          style: const TextStyle(fontSize: 12),),
      trailing: followButton(),
    );
  }
}

class FollowersTab extends StatefulWidget {
  final String userUid;

  const FollowersTab({super.key, required this.userUid});

  @override
  _FollowersTabState createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab> {
  bool _isLoading = true;
  List<Datum> _followers = [];

  @override
  void initState() {
    super.initState();
    _fetchFollowers();
  }

  void updateState() {
    if (mounted && context.mounted) {
      setState(() {});
    }
  }

  Future<void> _fetchFollowers() async {
    final response = await UserRelationsApi.getAllFollowers(
      userUid: widget.userUid,
      page: 1,
    );

    _followers = response?.data ?? [];
    _isLoading = false;
    updateState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _followers.isEmpty
            ? const Center(child: Text('No Followers'))
            : ListView.separated(
                padding: const EdgeInsets.all(8.0),
                separatorBuilder: (context, index) => Gap(8.0),
                itemCount: _followers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        showAppModalSheet(
                            flexibleSheet: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                WhatsevrButton.text(
                                  label: 'Remove Follower',
                                  onPressed: () {
                                    UserRelationsApi.removeFollower(
                                      followeeUserUid:
                                          AuthUserDb.getLastLoggedUserUid()!,
                                      followerUserUid:
                                          _followers[index].user!.uid!,
                                    );
                                  },
                                ),
                              ],
                            ),);
                      },
                      child: _UserInfo(
                        user: _followers[index].user!,
                        onFollow: () {
                          // Handle follow action
                        },
                      ),);
                },
              );
  }
}

class FollowingTab extends StatefulWidget {
  final String userUid;

  const FollowingTab({super.key, required this.userUid});

  @override
  _FollowingTabState createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab> {
  bool _isLoading = true;
  List<Datum> _following = [];

  @override
  void initState() {
    super.initState();
    _fetchFollowing();
  }

  void updateState() {
    if (mounted && context.mounted) {
      setState(() {});
    }
  }

  Future<void> _fetchFollowing() async {
    final response = await UserRelationsApi.getAllFollowing(
      userUid: widget.userUid,
      page: 1,
    );

    _following = response?.data ?? [];
    _isLoading = false;

    updateState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _following.isEmpty
            ? const Center(child: Text('No Following'))
            : ListView.separated(
                padding: const EdgeInsets.all(8.0),
                separatorBuilder: (context, index) => Gap(8.0),
                itemCount: _following.length,
                itemBuilder: (context, index) {
                  return _UserInfo(
                    user: _following[index].user!,
                    onFollow: () {
                      // Handle follow action
                    },
                  );
                },
              );
  }
}

class ConnectionsTab extends StatefulWidget {
  final String userUid;

  const ConnectionsTab({super.key, required this.userUid});

  @override
  _ConnectionsTabState createState() => _ConnectionsTabState();
}

class _ConnectionsTabState extends State<ConnectionsTab> {
  bool _isLoading = true;
  List<Datum> _connections = [];

  @override
  void initState() {
    super.initState();
    _fetchConnections();
  }

  void updateState() {
    if (mounted && context.mounted) {
      setState(() {});
    }
  }

  Future<void> _fetchConnections() async {
    final response = await UserRelationsApi.getMutualConnections(
      userUid: widget.userUid,
      page: 1,
    );

    _connections = response?.data ?? [];
    _isLoading = false;
    updateState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _connections.isEmpty
            ? const Center(child: Text('No Connections'))
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _connections.length,
                itemBuilder: (context, index) {
                  return _UserInfo(
                    isCard: true,
                    user: _connections[index].user!,
                    onFollow: () {
                      // Handle follow action
                    },
                  );
                },
              );
  }
}

class MutualFollowings extends StatefulWidget {
  final String userUid;

  const MutualFollowings({super.key, required this.userUid});

  @override
  _MutualFollowingsState createState() => _MutualFollowingsState();
}

class _MutualFollowingsState extends State<MutualFollowings> {
  bool _isLoading = true;
  List<Datum> _mutualFollowings = [];

  @override
  void initState() {
    super.initState();
    _fetchMutualFollowings();
  }

  void updateState() {
    if (mounted && context.mounted) {
      setState(() {});
    }
  }

  Future<void> _fetchMutualFollowings() async {
    final response = await UserRelationsApi.getMutualFollowing(
      userUid1: AuthUserDb.getLastLoggedUserUid()!,
      userUid2: widget.userUid,
      page: 1,
    );

    _mutualFollowings = response?.data ?? [];
    _isLoading = false;
    updateState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _mutualFollowings.isEmpty
            ? const Center(child: Text('No Mutual Followings'))
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _mutualFollowings.length,
                itemBuilder: (context, index) {
                  return _UserInfo(
                    user: _mutualFollowings[index].user!,
                    onFollow: () {
                      // Handle follow action
                    },
                  );
                },
              );
  }
}
