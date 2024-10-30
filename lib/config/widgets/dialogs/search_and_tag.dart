import 'package:easy_debounce/easy_debounce.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import '../../api/methods/text_search.dart';
import '../../api/response_model/text_search_users_communities.dart';
import '../../mocks/mocks.dart';
import '../buttons/button.dart';
import '../textfield/super_textform_field.dart';

class SearchAndTagUsersAndCommunityPage extends StatefulWidget {
  final bool scaffoldView;
  final Function(
          List<String> selectedUsersUid, List<String> selectedCommunitiesUid,)?
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
        const Duration(milliseconds: 600),
        () async {
          final TextSearchUsersAndCommunitiesResponse? response =
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
    final Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WhatsevrFormField.textFieldWithClearIcon(
          controller: controller,
          hintText: 'Search for users or communities',
          onChanged: (String value) {
            _fetchData(value);
          },
        ),
        const Gap(8),
        if (searchedItems?.users?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text('Users'),
          const Gap(8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchedItems?.users?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return const Gap(4);
            },
            itemBuilder: (BuildContext context, int index) {
              final User? user = searchedItems?.users?[index];
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
                      user?.profilePicture ?? MockData.blankProfileAvatar,),
                ),
                title: Text(
                  '${user?.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('@${user?.username}'),
                trailing: selectedUsersUid.contains(user?.uid)
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.circle_outlined),
              );
            },
          ),
        ],
        if (searchedItems?.communities?.isNotEmpty ?? false) ...[
          const Gap(8),
          const Text('Communities'),
          const Gap(8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchedItems?.communities?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return const Gap(4);
            },
            itemBuilder: (BuildContext context, int index) {
              final Community? community = searchedItems?.communities?[index];
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
                      community?.profilePicture ?? MockData.blankProfileAvatar,),
                ),
                title: Text(
                  '${community?.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('@${community?.username}'),
                trailing: selectedCommunitiesUid.contains(community?.uid)
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.circle_outlined),
              );
            },
          ),
        ],
        const Gap(8),
        if (selectedUsersUid.isNotEmpty ||
            selectedCommunitiesUid.isNotEmpty) ...[
          const Gap(50),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Selected ',
                  style: TextStyle(color: Colors.black),
                ),
                if (selectedUsersUid.isNotEmpty) ...[
                  TextSpan(
                    text: '${selectedUsersUid.length} users',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
                if (selectedUsersUid.isNotEmpty &&
                    selectedCommunitiesUid.isNotEmpty)
                  const TextSpan(
                    text: ' and ',
                    style: TextStyle(color: Colors.black),
                  ),
                if (selectedCommunitiesUid.isNotEmpty) ...[
                  TextSpan(
                    text: '${selectedCommunitiesUid.length} communities',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ],
            ),
          ),
          const Gap(8),
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
