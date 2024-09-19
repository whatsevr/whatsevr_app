import 'package:easy_debounce/easy_debounce.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/methods/text_search.dart';
import 'package:whatsevr_app/config/api/response_model/text_search_users_communities.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/widgets/button.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';

class SearchAndTagUsersAndCommunityPage extends StatefulWidget {
  final bool scaffoldView;
  final Function(
          List<String> selectedUsersUid, List<String> selectedCommunitiesUid)?
      onDone;
  const SearchAndTagUsersAndCommunityPage({
    super.key,
    this.scaffoldView = false,
    required this.onDone,
  });

  @override
  State<SearchAndTagUsersAndCommunityPage> createState() =>
      _SearchAndTagUsersAndCommunityPageState();
}

class _SearchAndTagUsersAndCommunityPageState
    extends State<SearchAndTagUsersAndCommunityPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchData(String inputText) async {
    try {
      EasyDebounce.debounce(
        'search-users-community-6425254',
        Duration(milliseconds: 600),
        () async {
          TextSearchUsersAndCommunitiesResponse? response =
              await TextSearchApi.searchUsersAndCommunities(query: inputText);

          if (response != null) {
            setState(() {
              searchedItems = response;
            });
          }
        },
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  TextSearchUsersAndCommunitiesResponse? searchedItems;
  List<String> selectedUsersUid = [];
  List<String> selectedCommunitiesUid = [];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WhatsevrFormField.textFieldWithClearIcon(
          controller: controller,
          hintText: 'Search for users or communities',
          onChanged: (String value) {
            _fetchData(value);
          },
        ),
        Gap(8),
        if (searchedItems?.users?.isNotEmpty ?? false) ...[
          Gap(8),
          Text('Users'),
          Gap(8),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchedItems?.users?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return Gap(4);
            },
            itemBuilder: (BuildContext context, int index) {
              User? user = searchedItems?.users?[index];
              return ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                onTap: () {
                  if (selectedUsersUid.contains(user?.uid)) {
                    selectedUsersUid.remove(user?.uid);
                  } else {
                    selectedUsersUid.add(user?.uid ?? '');
                  }
                  setState(() {});
                },
                leading: CircleAvatar(
                  backgroundImage: ExtendedNetworkImageProvider(
                      user?.profilePicture ?? MockData.imageAvatar),
                ),
                title: Text(
                  '${user?.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('@${user?.username}'),
                trailing: selectedUsersUid.contains(user?.uid)
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.circle_outlined),
              );
            },
          )
        ],
        if (searchedItems?.communities?.isNotEmpty ?? false) ...[
          Gap(8),
          Text('Communities'),
          Gap(8),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchedItems?.communities?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return Gap(4);
            },
            itemBuilder: (BuildContext context, int index) {
              Community? community = searchedItems?.communities?[index];
              return ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                onTap: () {
                  if (selectedCommunitiesUid.contains(community?.uid)) {
                    selectedCommunitiesUid.remove(community?.uid);
                  } else {
                    selectedCommunitiesUid.add(community?.uid ?? '');
                  }
                  setState(() {});
                },
                leading: CircleAvatar(
                  backgroundImage: ExtendedNetworkImageProvider(
                      community?.profilePicture ?? MockData.imageAvatar),
                ),
                title: Text(
                  '${community?.title}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('@${community?.username}'),
                trailing: selectedCommunitiesUid.contains(community?.uid)
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.circle_outlined),
              );
            },
          ),
        ],
        Gap(8),
        if (selectedUsersUid.isNotEmpty ||
            selectedCommunitiesUid.isNotEmpty) ...[
          Gap(50),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Selected ',
                  style: TextStyle(color: Colors.black),
                ),
                if (selectedUsersUid.isNotEmpty) ...[
                  TextSpan(
                    text: '${selectedUsersUid.length} users',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
                if (selectedUsersUid.isNotEmpty &&
                    selectedCommunitiesUid.isNotEmpty)
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(color: Colors.black),
                  ),
                if (selectedCommunitiesUid.isNotEmpty) ...[
                  TextSpan(
                    text: '${selectedCommunitiesUid.length} communities',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ],
            ),
          ),
          Gap(8),
          WhatsevrButton.filled(
            label: 'Done',
            onPressed: () {
              widget.onDone?.call(selectedUsersUid, selectedCommunitiesUid);
              Navigator.pop(context);
            },
          ),
        ],
      ],
    );
    if (widget.scaffoldView) {
      return Scaffold(
        body: child,
      );
    }
    return child;
  }
}
