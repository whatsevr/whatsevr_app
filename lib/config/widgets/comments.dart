import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
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

class Comment {
  final String? comment;
  final String? commentUid;
  final String? authorUid;
  final String? authorName;
  final String? authorAvatar;
  final String? createdAt;
  final List<Reply>? replies;

  Comment({
    this.comment,
    this.commentUid,
    this.authorUid,
    this.authorName,
    this.authorAvatar,
    this.createdAt,
    this.replies,
  });
}

class Reply {
  final String? reply;
  final String? replyUid;
  final String? commentUid;
  final String? authorUid;
  final String? authorName;
  final String? authorAvatar;
  final String? createdAt;

  Reply({
    this.reply,
    this.replyUid,
    this.commentUid,
    this.authorUid,
    this.authorName,
    this.authorAvatar,
    this.createdAt,
  });
}

class _Ui extends StatefulWidget {
  final String? videoPostUid;

  const _Ui({super.key, this.videoPostUid});

  @override
  State<_Ui> createState() => _UiState();
}

class _UiState extends State<_Ui> {
  List<Comment> _comments = [
    Comment(
      comment:
          'This is a comment This is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a commentThis is a comment',
      authorName: 'John Doe',
      authorAvatar: MockData.randomImageAvatar(),
      createdAt: DateTime.now().toString(),
      replies: [
        Reply(
          reply: 'This is a reply',
          authorName: 'Jane Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
        Reply(
          reply: 'This is another reply',
          authorName: 'John Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
      ],
    ),
    Comment(
      comment: 'This is a comment',
      authorName: 'John Doe',
      authorAvatar: MockData.randomImageAvatar(),
      createdAt: DateTime.now().toString(),
      replies: [
        Reply(
          reply: 'This is a reply',
          authorName: 'Jane Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
        Reply(
          reply: 'This is another reply',
          authorName: 'John Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
      ],
    ),
    Comment(
      comment: 'This is a comment',
      authorName: 'John Doe',
      authorAvatar: MockData.randomImageAvatar(),
      createdAt: DateTime.now().toString(),
      replies: [
        Reply(
          reply: 'This is a reply',
          authorName: 'Jane Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
        Reply(
          reply:
              'This is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another replyThis is another reply',
          authorName: 'John Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
      ],
    ),
    Comment(
      comment: 'This is a comment',
      authorName: 'John Doe',
      createdAt: DateTime.now().toString(),
      replies: [
        Reply(
          reply: 'This is a reply',
          authorName: 'Jane Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
        Reply(
          reply: 'This is another reply',
          authorName: 'John Doe',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
      ],
    ),
    Comment(
      comment: 'This is another comment',
      authorName: 'Jane Doe',
      authorAvatar: MockData.randomImageAvatar(),
      createdAt: DateTime.now().toString(),
      replies: [
        Reply(
          reply: 'This is another reply',
          authorName: 'John Doe',
          createdAt: DateTime.now().toString(),
        ),
      ],
    ),
  ];
  final TextEditingController _controller = TextEditingController();

  void _addComment(String text) {
    setState(() {
      _comments = [
        Comment(
          comment: text,
          authorName: 'Current User',
          authorAvatar: MockData.randomImageAvatar(),
          createdAt: DateTime.now().toString(),
        ),
        ..._comments
      ];
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Builder(builder: (context) {
            if (_comments.isEmpty) {
              return const Center(
                child: Text(
                  'Be the first to comment',
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
                var comment = _comments[index];
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
                                  photoUrl: comment.authorAvatar,
                                  appBarTitle: comment.authorName,
                                );
                              },
                              child: ExtendedImage.network(
                                comment.authorAvatar ??
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
                                      comment.authorName ?? 'Anonymous',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      comment.createdAt ?? '',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(comment.comment ?? ''),
                                const SizedBox(height: 4),
                                Text(
                                  '${comment.replies?.length ?? 0} replies',
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (comment.replies != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var reply in comment.replies ?? [])
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          showPhotoPreviewDialog(
                                            context: context,
                                            photoUrl: reply.authorAvatar,
                                            appBarTitle: reply.authorName,
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            reply.authorAvatar ??
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
                                                  reply.authorName ??
                                                      'Anonymous',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  reply.createdAt ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(reply.reply ?? ''),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Text('Reply',
                                  style: const TextStyle(color: Colors.blue)),
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
                  hintText: 'Add a comment',
                  minLines: 1,
                  maxLines: 4,
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
