import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/multiple_user_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';

void showTaggedUsersBottomSheet(BuildContext context,
    {List<String>? taggedUserUids}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return _Ui(taggedUserUids: taggedUserUids);
    },
  );
}

class _Ui extends StatefulWidget {
  final List<String>? taggedUserUids;
  const _Ui({super.key, required this.taggedUserUids});

  @override
  State<_Ui> createState() => _UiState();
}

class _UiState extends State<_Ui> {
  MultipleUserDetailsResponse? _multipleUserDetailsResponse;

  @override
  void initState() {
    super.initState();
    if (widget.taggedUserUids != null) {
      UsersApi.getMultipleUserDetails(userUids: widget.taggedUserUids!)
          .then((value) {
        setState(() {
          _multipleUserDetailsResponse = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Tagged',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Builder(
            builder: (context) {
              if (_multipleUserDetailsResponse == null) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (_multipleUserDetailsResponse!.users!.isEmpty) {
                return const Center(child: Text('No tags'));
              }
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final user = _multipleUserDetailsResponse!.users![index];
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            user.profilePicture ?? MockData.imageAvatar),
                      ),
                      const Gap(8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${user.name}'),
                            Text('${user.totalFollowers} followers'),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Gap(8);
                },
                itemCount: _multipleUserDetailsResponse?.users?.length ?? 0,
              );
            },
          ),
        ],
      ),
    );
  }
}