import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/api/response_model/chats/chat_messages.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/detectable_text.dart';
import 'package:whatsevr_app/src/features/chat/conversation/bloc/conversation_bloc.dart';

class ConversationPageArguments {
  final bool isCommunity;
  final String? communityUid;
  final String? privateChatUid;
  final String? title;
  final String? profilePicture;

  ConversationPageArguments({
    required this.isCommunity,
    this.communityUid,
    this.privateChatUid,
    this.title,
    this.profilePicture,
  });
}

class ConversationsPage extends StatelessWidget {
  final ConversationPageArguments pageArguments;

  const ConversationsPage({
    super.key,
    required this.pageArguments,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;
    final scrollController = ScrollController();
    final messageController = TextEditingController();

    return BlocProvider(
      create: (context) => ConversationBloc(
        AuthUserDb.getLastLoggedUserUid()!,
      )..add(InitialEvent(pageArguments: pageArguments)),
      child: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: theme.background,
              image: DecorationImage(
                image: ExtendedNetworkImageProvider(
                  'https://dxvbdpxfzdpgiscphujy.supabase.co/storage/v1/object/public/assets/bg-pattern1245.jpg',
                  cache: true,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  theme.background.withOpacity(0.95),
                  BlendMode.overlay,
                ),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context, state),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: ListView.builder(
                            reverse: true,
                            controller: scrollController,
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              final message = state.messages[index];
                              final isCurrentUser = message.senderUid ==
                                  AuthUserDb.getLastLoggedUserUid();

                              return Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: MessageBubble(
                                  message: message,
                                  isCurrentUser: isCurrentUser,
                                  isCommunity: pageArguments.isCommunity,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadow.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, -2),
                            ),
                          ],
                        ),
                        child: MessageComposer(
                          controller: messageController,
                          onSend: (content) {
                            context.read<ConversationBloc>().add(
                                  SendMessage(
                                    content: content,
                                  ),
                                );
                            messageController.clear();
                          },
                          onAttachmentTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value:
                                    BlocProvider.of<ConversationBloc>(context),
                                child: const AttachmentSheet(),
                              ),
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  if (scrollController.hasClients &&
                      scrollController.offset > 1000)
                    Positioned(
                      right: 16,
                      bottom: 80,
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: theme.accent,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: theme.surface,
                        ),
                        onPressed: () {
                          scrollController.animateTo(
                            // Changed from controller to scrollController
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ConversationState state,
  ) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: ExtendedNetworkImageProvider(
              state.profilePicture ??
                  (state.isCommunity
                      ? MockData.blankCommunityAvatar
                      : MockData.blankProfileAvatar),
            ),
            radius: 18,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.title ?? (state.isCommunity ? 'Community' : 'Chat'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {
            // Handle more options
          },
        ),
      ],
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final bool isCommunity;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.isCommunity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;
    final state = context.read<ConversationBloc>().state;
    final sender = message.sender;

    return Padding(
      padding: EdgeInsets.only(
        left: isCurrentUser ? 50 : 0,
        right: isCurrentUser ? 0 : 50,
        bottom: 4,
      ),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: ExtendedNetworkImageProvider(
                sender?.profilePicture ?? MockData.blankProfileAvatar,
              ),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: GestureDetector(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => MessageActionsSheet(
                    message: message,
                    isCurrentUser: isCurrentUser,
                    onDelete: () {
                      context.read<ConversationBloc>().add(
                            DeleteMessage(messageUid: message.uid!),
                          );
                      Navigator.pop(context);
                    },
                    onEdit: isCurrentUser
                        ? () {
                            Navigator.pop(context);
                            _showEditDialog(context, message);
                          }
                        : null,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isCurrentUser
                      ? LinearGradient(
                          colors: theme.darkGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: theme.accentGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  color: isCurrentUser ? null : theme.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
                    bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadow.withOpacity(0.1),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: isCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isCommunity && !isCurrentUser && sender != null)
                      Text(
                        sender.name ?? sender.username ?? '',
                        style: TextStyle(
                          color: theme.surface,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    WhatsevrMessageDetectableText(
                      text: message.message ?? '',
                      trimLines: 8,
                      basicStyleColor: theme.surface,
                      detectedStyleColor: theme.surface,
                    ),
                    // Add media content previews
                    if (message.flick != null) ...[
                      Gap(8),
                      _buildMediaPreview(
                        context,
                        message.flick!.thumbnail!,
                      ),
                    ],
                    if (message.videoPost != null) ...[
                      Gap(8),
                      _buildMediaPreview(
                        context,
                        message.videoPost!.thumbnail!,
                      ),
                    ],
                    if (message.memory != null &&
                        message.memory!.imageUrl != null) ...[
                      Gap(8),
                      _buildMediaPreview(
                        context,
                        message.memory!.imageUrl!,
                      ),
                    ],
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('h:mm a').format(message.createdAt!),
                          style: TextStyle(
                            color: theme.surface,
                            fontSize: 10,
                          ),
                        ),
                        Gap(8),
                        if (isCurrentUser) ...[
                          if (message.uid?.startsWith('temp_') == true)
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: theme.surface,
                            ),
                          if (message.uid?.startsWith('temp_') == false)
                            Icon(Icons.done_all, size: 12, color: theme.text),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaPreview(BuildContext context, String url) {
    final theme = context.whatsevrTheme;
    return GestureDetector(
      onTap: () {
        // TODO: Implement media preview/playback
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 200,
          maxHeight: 200,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ExtendedImage.network(
            url,
            fit: BoxFit.cover,
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(theme.accent),
                  ),
                );
              } else if (state.extendedImageLoadState == LoadState.failed) {
                return Container(
                  color: theme.background,
                  child: Center(
                    child: Icon(Icons.error, color: theme.accent),
                  ),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Message message) {
    final TextEditingController editController =
        TextEditingController(text: message.message);
    final theme = context.whatsevrTheme;

    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ConversationBloc>(context),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: theme.shadow.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Message',
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: theme.icon),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  controller: editController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                  maxLines: null,
                  autofocus: true,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: theme.textLight,
                      ),
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ConversationBloc>().add(
                              EditMessage(
                                messageId: message.uid!,
                                newContent: editController.text,
                              ),
                            );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.accent,
                        foregroundColor: theme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// New widget for message composition
class MessageComposer extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend; // Changed from VoidCallback
  final VoidCallback onAttachmentTap;
// Added this parameter

  const MessageComposer({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachmentTap,
    // Added this parameter
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.insert_emoticon, color: theme.icon, size: 20),
            onPressed: () {}, // TODO: Implement emoji picker
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: theme.borderRadiusLarge,
                border: theme.border,
              ),
              child: TextField(
                controller: controller,
                style: theme.bodySmall,
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  border: InputBorder.none,
                  hintStyle: theme.bodySmall.copyWith(color: theme.textLight),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.attach_file, color: theme.icon, size: 20),
            onPressed: onAttachmentTap,
          ),
          GestureDetector(
            onTap: () => onSend(controller.text), // Pass the text to onSend
            child: CircleAvatar(
              radius: 18,
              backgroundColor: theme.accent,
              child: Icon(Icons.send, color: theme.surface, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// New widget for attachment options
class AttachmentSheet extends StatelessWidget {
  const AttachmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildAttachmentOption(Icons.image, 'Photo', () {}, Colors.green),
              _buildAttachmentOption(
                Icons.videocam,
                'Video',
                () {},
                Colors.red,
              ),
              _buildAttachmentOption(
                Icons.insert_drive_file,
                'Document',
                () {},
                Colors.blue,
              ),
              _buildAttachmentOption(
                Icons.location_on,
                'Location',
                () {},
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption(
    IconData icon,
    String label,
    VoidCallback onTap,
    Color color,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Update MessageActionsSheet
class MessageActionsSheet extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const MessageActionsSheet({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isCurrentUser) ...[
                        _buildActionTile(
                          icon: Icons.edit,
                          label: 'Edit Message',
                          onTap: onEdit,
                          iconColor: Colors.blue,
                        ),
                        _buildActionTile(
                          icon: Icons.delete,
                          label: 'Delete Message',
                          onTap: onDelete,
                          isDestructive: true,
                        ),
                        Divider(height: 1, indent: 16, endIndent: 16),
                      ],
                      _buildActionTile(
                        icon: Icons.copy,
                        label: 'Copy Text',
                        onTap: () {
                          // TODO: Implement copy
                          Navigator.pop(context);
                        },
                        iconColor: Colors.purple,
                      ),
                      _buildActionTile(
                        icon: Icons.reply,
                        label: 'Reply',
                        onTap: () {
                          // TODO: Implement reply
                          Navigator.pop(context);
                        },
                        iconColor: Colors.green,
                      ),
                      _buildActionTile(
                        icon: Icons.forward,
                        label: 'Forward',
                        onTap: () {
                          // TODO: Implement forward
                          Navigator.pop(context);
                        },
                        iconColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message.message ?? '',
                    style: TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isDestructive = false,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      (iconColor ?? (isDestructive ? Colors.red : Colors.blue))
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? (isDestructive ? Colors.red : null),
                  size: 20,
                ),
              ),
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isDestructive ? Colors.red : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add new animation for message deletion
class AnimatedMessageItem extends StatelessWidget {
  final Widget child;
  final VoidCallback onDismissed;

  const AnimatedMessageItem({
    super.key,
    required this.child,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: child,
    );
  }
}
