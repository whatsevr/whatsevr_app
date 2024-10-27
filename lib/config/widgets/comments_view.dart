import 'dart:io';

import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whatsevr_app/config/api/external/models/pagination_data.dart';
import 'package:whatsevr_app/config/api/methods/comments.dart';
import 'package:whatsevr_app/config/api/methods/users.dart';
import 'package:whatsevr_app/config/api/requests_model/comments/comment_and_reply.dart';
import 'package:whatsevr_app/config/api/response_model/comments/get_comments.dart'
    as m1;
import 'package:whatsevr_app/config/api/response_model/user_details.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/file_upload.dart';
import 'package:whatsevr_app/config/widgets/choice_chip.dart';
import 'package:whatsevr_app/config/widgets/max_scroll_listener.dart';
import 'package:whatsevr_app/config/widgets/media/asset_picker.dart';
import 'package:whatsevr_app/config/widgets/media/media_pick_choice.dart';
import 'package:whatsevr_app/config/widgets/previewers/photo.dart';
import 'package:whatsevr_app/config/widgets/showAppModalSheet.dart';
import 'package:whatsevr_app/config/widgets/stack_toast.dart';
import 'package:whatsevr_app/config/widgets/super_textform_field.dart';

void showCommentsDialog({
  String? videoPostUid,
  String? photoPostUid,
  String? pdfUid,
  String? memoryUid,
  String? offerPostUid,
  String? flickPostUid,
}) {
  int nonNullCount = [
    videoPostUid,
    photoPostUid,
    pdfUid,
    memoryUid,
    offerPostUid,
    flickPostUid
  ].where((element) => element != null).length;

  if (nonNullCount != 1) {
    throw ArgumentError('Only one parameter should be non-null');
  }
  showAppModalSheet(
      transparentMask: true,
      flexibleSheet: false,
      resizeToAvoidBottomInset: false,
      maxSheetHeight: 0.8,
      child: _Ui(
        videoPostUid: videoPostUid,
        photoPostUid: photoPostUid,
        pdfUid: pdfUid,
        memoryUid: memoryUid,
        offerPostUid: offerPostUid,
        flickPostUid: flickPostUid,
      ));
}

class _Ui extends StatefulWidget {
  final String? videoPostUid;
  final String? photoPostUid;
  final String? pdfUid;
  final String? memoryUid;
  final String? offerPostUid;
  final String? flickPostUid;

  const _Ui({
    super.key,
    this.videoPostUid,
    this.photoPostUid,
    this.pdfUid,
    this.memoryUid,
    this.offerPostUid,
    this.flickPostUid,
  });

  @override
  State<_Ui> createState() => _UiState();
}

class _UiState extends State<_Ui> {
  List<m1.Comment> _comments = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  PaginationData? commentsPaginationData = PaginationData();
  m1.Comment? replyingToTheComment;
  bool isTopComments = false;
  File? _imageFile;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCurrentUserDetails();
    getComments(1);
    onReachingEndOfTheList(scrollController, execute: () {
      getComments((commentsPaginationData?.currentPage ?? 0) + 1);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  UserDetailsResponse? currentUserDetails;

  void getCurrentUserDetails() async {
    String? userUid = AuthUserDb.getLastLoggedUserUid();
    currentUserDetails = await UsersApi.getUserDetails(userUid: userUid!);
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
      photoPostUid: widget.photoPostUid,
      pdfUid: widget.pdfUid,
      memoryUid: widget.memoryUid,
      offerPostUid: widget.offerPostUid,
      flickPostUid: widget.flickPostUid,
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

  void removeAttachments() {
    setState(() {
      _imageFile = null;
    });
  }

  void _onPostCommentOrReply(String text) async {
    _controller.clear();
    WhatsevrStackToast.showInfo(
        replyingToTheComment != null ? 'Adding reply...' : 'Adding comment...');
    String? imageUrl;
    if (_imageFile != null) {
      File imageFile = _imageFile!;
      removeAttachments();
      imageUrl = await FileUploadService.uploadFilesToSupabase(
        imageFile,
        userUid: AuthUserDb.getLastLoggedUserUid()!,
        fileRelatedTo: 'comment',
      );
    }
    (int?, String?, String?)? replyResponse =
        await CommentsApi.postCommentOrReply(CommentAndReplyRequest(
      commentText: replyingToTheComment != null ? null : text,
      replyText: replyingToTheComment != null ? text : null,
      userUid: AuthUserDb.getLastLoggedUserUid(),
      videoPostUid: widget.videoPostUid,
      commentUid: replyingToTheComment?.uid,
      flickPostUid: widget.flickPostUid,
      memoryUid: widget.memoryUid,
      offerPostUid: widget.offerPostUid,
      pdfUid: widget.pdfUid,
      photoPostUid: widget.photoPostUid,
      imageUrl: imageUrl,
    ));
    if (replyResponse?.$1 != HttpStatus.ok) {
      SmartDialog.showToast('${replyResponse?.$2}');
      return;
    }
    setState(() {
      if (replyingToTheComment != null) {
        final updatedReplies = [
          m1.UserCommentReply(
            replyText: text,
            commentUid: replyingToTheComment?.uid,
            userUid: currentUserDetails?.data?.uid,
            author: m1.UserCommentReplyAuthor.fromMap(
              currentUserDetails?.data?.toMap() ?? {},
            ),
            createdAt: DateTime.now(),
          ),
          ...?replyingToTheComment!.userCommentReplies,
        ];

        setState(() {
          _comments = _comments.map((comment) {
            if (comment == replyingToTheComment) {
              return comment.copyWith(userCommentReplies: updatedReplies);
            }
            return comment;
          }).toList();
          replyingToTheComment = null;
        });
      } else {
        _comments = [
          m1.Comment(
            uid: replyResponse?.$3,
            commentText: text,
            userUid: currentUserDetails?.data?.uid,
            videoPostUid: widget.videoPostUid,
            imageUrl: imageUrl,
            author: m1.CommentAuthor.fromMap(
              currentUserDetails?.data?.toMap() ?? {},
            ),
            createdAt: DateTime.now(),
          ),
          ..._comments
        ];
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _replyToComment(m1.Comment comment) {
    setState(() {
      replyingToTheComment = comment;
    });

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (replyingToTheComment != null)
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          replyingToTheComment = null;
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
              if (_imageFile != null)
                Stack(
                  children: [
                    GestureDetector(
                        onTap: () {
                          showPhotoPreviewDialog(
                            context: context,
                            photoUrl: _imageFile!.path,
                            appBarTitle: 'Preview',
                          );
                        },
                        child: ExtendedImage.file(
                          _imageFile!,
                          height: 80,
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _imageFile = null;
                          });
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.red,
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
                        hintText: replyingToTheComment != null
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
                              cache: true,
                            ),
                            radius: 15,
                          ),
                        ),
                        suffixWidget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.attach_file),
                              color: Colors.black,
                              onPressed: () {
                                showWhatsevrMediaPickerChoice(
                                  onChoosingImageFromGallery: () {
                                    CustomAssetPicker.pickImageFromGallery(
                                        quality: 50,
                                        editImage: false,
                                        onCompleted: (File file) {
                                          setState(() {
                                            _imageFile = file;
                                          });
                                        });
                                  },
                                );
                              },
                            ),
                            GestureDetector(
                              child: const Icon(
                                Icons.send,
                                color: Colors.black,
                                size: 22,
                              ),
                              onTap: () {
                                if (_controller.text.isNotEmpty) {
                                  _onPostCommentOrReply(_controller.text);
                                }
                              },
                            ),
                            Gap(4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      body: Column(
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
                        _comments.sort(
                            (a, b) => a.createdAt!.compareTo(b.createdAt!));
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
                controller: scrollController,
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
                                  if (comment.commentText?.isNotEmpty ??
                                      false) ...[
                                    const SizedBox(height: 4),
                                    Text(comment.commentText ?? '')
                                  ],
                                  if (comment.imageUrl?.isNotEmpty ??
                                      false) ...[
                                    const SizedBox(height: 4),
                                    GestureDetector(
                                      onTap: () {
                                        showPhotoPreviewDialog(
                                          context: context,
                                          photoUrl: comment.imageUrl,
                                          appBarTitle: comment.author?.name,
                                        );
                                      },
                                      child: ExtendedImage.network(
                                        comment.imageUrl!,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8),
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                        enableLoadState: false,
                                      ),
                                    ),
                                  ],
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
                              if (comment.userCommentReplies?.isNotEmpty ??
                                  false)
                                ExpansionTileFlat(
                                  tilePadding: EdgeInsets.zero,
                                  childrenPadding: EdgeInsets.zero,
                                  isDefaultVerticalPadding: false,
                                  title: Text(
                                      '${comment.userCommentReplies?.length ?? 0} reply'),
                                  children: [
                                    for (m1.UserCommentReply reply
                                        in comment.userCommentReplies ?? [])
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                showPhotoPreviewDialog(
                                                  context: context,
                                                  photoUrl: reply
                                                      .author?.profilePicture,
                                                  appBarTitle:
                                                      reply.author?.name,
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundImage:
                                                    ExtendedNetworkImageProvider(
                                                  reply.author
                                                          ?.profilePicture ??
                                                      MockData
                                                          .blankProfileAvatar,
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
                                                        reply.author?.name ??
                                                            'Unknown',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                  ],
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
        ],
      ),
    );
  }
}
