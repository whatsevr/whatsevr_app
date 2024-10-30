import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../mocks/mocks.dart';
import '../../services/auth_db.dart';
import '../app_bar.dart';
import '../tab_bar.dart';
import '../../api/methods/user_relations.dart';
import '../../api/response_model/user_relations/user_relations.dart';

void showUserRelationsDialog(
    {required BuildContext context, required String userUid}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return _UserRelationsPage(userUid: userUid);
    },
  );
}

class _UserRelationsPage extends StatefulWidget {
  final String userUid;

  const _UserRelationsPage({Key? key, required this.userUid}) : super(key: key);

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
          if (AuthUserDb.getLastLoggedUserUid() != widget.userUid)
            ('Connections', ConnectionsTab(userUid: widget.userUid)),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onFollow;

  const UserCard({
    Key? key,
    required this.user,
    required this.onFollow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: onFollow,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Follow'),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowersTab extends StatefulWidget {
  final String userUid;

  const FollowersTab({Key? key, required this.userUid}) : super(key: key);

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

  Future<void> _fetchFollowers() async {
    final response = await UserRelationsApi.getAllFollowers(
      userUid: widget.userUid,
      page: 1,
    );
    setState(() {
      _followers = response?.data ?? [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _followers.isEmpty
            ? const Center(child: Text('No Followers'))
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _followers.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    user: _followers[index].user!,
                    onFollow: () {
                      // Handle follow action
                    },
                  );
                },
              );
  }
}

class FollowingTab extends StatefulWidget {
  final String userUid;

  const FollowingTab({Key? key, required this.userUid}) : super(key: key);

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

  Future<void> _fetchFollowing() async {
    final response = await UserRelationsApi.getAllFollowing(
      userUid: widget.userUid,
      page: 1,
    );
    setState(() {
      _following = response?.data ?? [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _following.isEmpty
            ? const Center(child: Text('No Following'))
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _following.length,
                itemBuilder: (context, index) {
                  return UserCard(
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

  const ConnectionsTab({Key? key, required this.userUid}) : super(key: key);

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

  Future<void> _fetchConnections() async {
    final response = await UserRelationsApi.getMutualConnections(
      userUid: widget.userUid,
      page: 1,
    );
    setState(() {
      _connections = response?.data ?? [];
      _isLoading = false;
    });
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
                  return UserCard(
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

  const MutualFollowings({Key? key, required this.userUid}) : super(key: key);

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

  Future<void> _fetchMutualFollowings() async {
    final response = await UserRelationsApi.getMutualFollowing(
      userUid1: AuthUserDb.getLastLoggedUserUid()!,
      userUid2: widget.userUid,
      page: 1,
    );
    setState(() {
      _mutualFollowings = response?.data ?? [];
      _isLoading = false;
    });
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
                  return UserCard(
                    user: _mutualFollowings[index].user!,
                    onFollow: () {
                      // Handle follow action
                    },
                  );
                },
              );
  }
}
