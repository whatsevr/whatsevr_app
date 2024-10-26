import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/comments.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/response_model/comments/get_comments.dart'
    as m1;
import 'package:whatsevr_app/config/api/response_model/user_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/widgets/choice_chip.dart';
import 'package:whatsevr_app/config/widgets/previewers/photo.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';

showCommentsDialog({
  String? videoPostUid,
}) {
  showAppModalSheet(
      transparentMask: true,
      flexibleSheet: false,
      maxSheetHeight: 0.7,
      child: _Ui(
        videoPostUid: videoPostUid,
      ));
}

class _Ui extends StatefulWidget {
  final String? videoPostUid;

  const _Ui({super.key, this.videoPostUid});

  @override
  State<_Ui> createState() => _UiState();
}

class _UiState extends State<_Ui> {
  List<m1.Comment> _comments = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  PaginationData? commentsPaginationData = PaginationData();
  m1.Comment? commentReplyingTo;
  bool isTopComments = false;
  @override
  void initState() {
    super.initState();
    getCurrentUserDetails();
    getComments(1);
  }

  UserDetailsResponse? currentUserDetails;
  void getCurrentUserDetails() async {
    String? userUid = AuthUserDb.getLastLoggedUserUid();
    currentUserDetails = await UsersApi.getUserDetails(userUid: userUid!);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void getComments(int page) async {
    if (commentsPaginationData?.noMoreData == true ||
        commentsPaginationData?.isLoading == true) {
      return;
    }
    commentsPaginationData = commentsPaginationData?.copyWith(isLoading: true);
    m1.GetCommentsResponse? response = await CommentsApi.getComments(
      page: page,
      videoPostUid: widget.videoPostUid,
    );
    if (response != null) {
      setState(() {
        _comments = [..._comments, ...(response.comments ?? [])];
        commentsPaginationData = commentsPaginationData?.copyWith(
          isLoading: false,
          currentPage: page,
          noMoreData: response.lastPage,
        );
      });
    }
  }

  void _addComment(String text) {
    setState(() {
      if (commentReplyingTo != null) {
        final updatedReplies = [
          m1.UserCommentReply(
            replyText: text,
            author: m1.UserCommentReplyAuthor(
              name: 'You',
            ),
            createdAt: DateTime.now(),
          ),
          ...?commentReplyingTo!.userCommentReplies,
        ];

        setState(() {
          _comments = _comments.map((comment) {
            if (comment == commentReplyingTo) {
              return comment.copyWith(userCommentReplies: updatedReplies);
            }
            return comment;
          }).toList();
          commentReplyingTo = null;
        });
      } else {
        _comments = [
          m1.Comment(
            commentText: text,
            author: m1.CommentAuthor(
              name: 'You',
            ),
            createdAt: DateTime.now(),
          ),
          ..._comments
        ];
      }
    });
    _controller.clear();
  }

  void _replyToComment(m1.Comment comment) {
    setState(() {
      commentReplyingTo = comment;
    });
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Gap(8),
        Row(
          children: [
            WhatsevrChoiceChip(
                choiced: isTopComments,
                switchChoice: (bool selected) {
                  if (_comments.isEmpty) return;

                  setState(() {
                    isTopComments = selected;
                    if (isTopComments) {
                      _comments.sort((a, b) => a.author!.totalFollowers!
                          .compareTo(b.author!.totalFollowers!));
                    } else {
                      _comments
                          .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
                    }
                    _comments = _comments.reversed.toList();
                  });
                },
                label: 'Top Comments'),
          ],
        ),
        const Gap(8),
        Expanded(
          child: Builder(builder: (context) {
            if (_comments.isEmpty) {
              return const Center(
                child: Text(
                  'Waiting for comments...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                m1.Comment comment = _comments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                showPhotoPreviewDialog(
                                  context: context,
                                  photoUrl: comment.author?.profilePicture,
                                  appBarTitle: comment.author?.name,
                                );
                              },
                              child: ExtendedImage.network(
                                comment.author?.profilePicture ??
                                    MockData.blankProfileAvatar,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                width: 80,
                                height: 80,
                              )),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      comment.author?.name ?? 'Anonymous',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    const SizedBox(width: 8),
                                    Text(
                                      GetTimeAgo.parse(comment.createdAt!) ??
                                          '',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(comment.commentText ?? ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (comment.userCommentReplies?.isNotEmpty ?? false)
                              Text(
                                '${comment.userCommentReplies?.length ?? 0} reply',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            for (m1.UserCommentReply reply
                                in comment.userCommentReplies ?? [])
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        showPhotoPreviewDialog(
                                          context: context,
                                          photoUrl:
                                              reply.author?.profilePicture,
                                          appBarTitle: reply.author?.name,
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          reply.author?.profilePicture ??
                                              MockData.blankProfileAvatar,
                                        ),
                                        radius: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                reply.author?.name ?? 'Unknown',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                              const SizedBox(width: 8),
                                              Text(
                                                GetTimeAgo.parse(
                                                    reply.createdAt!),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(reply.replyText ?? ''),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            GestureDetector(
                              onTap: () => _replyToComment(comment),
                              child: Text(
                                'Reply',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
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
          }),
        ),
        if (commentReplyingTo != null)
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    commentReplyingTo = null;
                  });
                },
                child: const Text(
                  'Cancel Reply',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: WhatsevrFormField.multilineTextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  hintText: commentReplyingTo != null
                      ? 'Add a reply'
                      : 'Add a comment',
                  minLines: 1,
                  maxLines: 4,
                  prefixWidget: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      backgroundImage: ExtendedNetworkImageProvider(
                        currentUserDetails?.data?.profilePicture ??
                            MockData.blankProfileAvatar,
                      ),
                      radius: 15,
                    ),
                  ),
                  suffixWidget: IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.black,
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _addComment(_controller.text);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
