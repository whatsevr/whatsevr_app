import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/src/features/chat/conversation/models/chat_message.dart';
import 'package:whatsevr_app/src/features/chat/conversation/models/whatsevr_user.dart';
import 'package:flutter/services.dart';

class ConversationsPage extends StatefulWidget {
  final List<ChatMessage> messages = List.generate(
    20,
    (index) => ChatMessage(
      uid: '$index',
      senderUid: index % 2 == 0 ? 'user1' : 'user2',
      message: 'This is message number $index',
      createdAt: DateTime.now().subtract(Duration(minutes: index * 5)),
      isRead: index < 5, // Last 5 messages are read
      isDelivered: true, // All messages are delivered
      readAt: index < 5
          ? DateTime.now().subtract(Duration(minutes: index * 2))
          : null,
      deliveredAt: DateTime.now().subtract(Duration(minutes: index)),
    ),
  );

  final String currentUserUid = 'user1'; // Define the current user's UID
  final bool isCommunity;
  final String? communityUid;
  final String? privateChatUid;

  final Map<String, WhatsevrUser> users = {
    'user1': WhatsevrUser(
      uid: 'user1',
      name: 'Alice',
    ),
    'user2': WhatsevrUser(
      uid: 'user2',
      name: 'Bob',
    ),
    // Add more users as needed
  };

  ConversationsPage({
    super.key,
    required this.isCommunity,
    this.communityUid,
    this.privateChatUid,
  }); // Add this parameter

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  bool _showScrollToBottom = false;
  bool _isTyping = false;
  bool _isLoading = false;
  bool _hasError = false;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 1000 && !_showScrollToBottom) {
      setState(() => _showScrollToBottom = true);
    } else if (_scrollController.offset <= 1000 && _showScrollToBottom) {
      setState(() => _showScrollToBottom = false);
    }
  }

  Widget _buildMessageBubble(ChatMessage message, bool isCurrentUser) {
    return Hero(
      tag: 'message-${message.uid}',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => MessageActionsSheet(
                message: message,
                isCurrentUser: isCurrentUser,
                onDelete: () {
                  // TODO: Implement delete
                  Navigator.pop(context);
                  setState(() {
                    widget.messages.removeWhere((m) => m.uid == message.uid);
                  });
                },
                onEdit: isCurrentUser
                    ? () {
                        Navigator.pop(context);
                        _showEditDialog(message);
                      }
                    : null,
              ),
            );
          },
          onHorizontalDragEnd: (details) {
            // Handle swipe to reply
            if (details.primaryVelocity! < 0) {
              // Show reply UI
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 6, horizontal: 10), // Reduced padding
            decoration: BoxDecoration(
              gradient: isCurrentUser
                  ? LinearGradient(
                      colors: context.whatsevrTheme.darkGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isCurrentUser ? null : context.whatsevrTheme.surface,
              borderRadius: context.whatsevrTheme.borderRadiusLarge,
              boxShadow: [
                BoxShadow(
                  color: context.whatsevrTheme.shadow,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isCommunity && !isCurrentUser)
                  Text(
                    widget.users[message.senderUid]?.name ?? 'Unknown',
                    style: context.whatsevrTheme.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.whatsevrTheme.textLight,
                    ),
                  ),
                SizedBox(height: 1),
                Text(
                  message.message ?? '',
                  style: context.whatsevrTheme.bodySmall.copyWith(
                    color: isCurrentUser
                        ? context.whatsevrTheme.surface
                        : context.whatsevrTheme.text,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${message.createdAt?.hour.toString().padLeft(2, '0')}:${message.createdAt?.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 9, // Decreased font size
                      ),
                    ),
                    if (isCurrentUser) ...[
                      SizedBox(width: 3),
                      Icon(
                        message.isRead ?? false
                            ? Icons.done_all
                            : message.isDelivered ?? false
                                ? Icons.done_all
                                : Icons.check,
                        size: 12,
                        color: message.isRead ?? false
                            ? Colors.blue
                            : Colors.grey[500],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(ChatMessage message) {
    final TextEditingController editController =
        TextEditingController(text: message.message);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Message',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
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
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      child: Text('Cancel'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement edit
                        setState(() {
                          final index = widget.messages
                              .indexWhere((m) => m.uid == message.uid);
                          if (index != -1) {
                            widget.messages[index] = message.copyWith(
                              message: editController.text,
                              isEdited: true,
                              updatedAt: DateTime.now(),
                            );
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 0.2), end: Offset.zero).animate(anim1),
          child: FadeTransition(
            opacity: anim1,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.isCommunity
                    ? widget.users[widget.currentUserUid]?.profilePicture ??
                        MockData.blankCommunityAvatar
                    : widget.users[widget.currentUserUid]?.profilePicture ??
                        MockData.blankProfileAvatar, // Contact avatar URL
              ),
              radius: 18,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isCommunity ? 'Group Name' : 'Contact Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.isCommunity ? '5 members' : 'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.isCommunity ? Colors.grey : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call, color: Colors.black),
            onPressed: () {
              // Handle video call
            },
          ),
          IconButton(
            icon: Icon(Icons.call, color: Colors.black),
            onPressed: () {
              // Handle voice call
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
        backgroundColor: theme.appBar,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.icon),
      ),
      body: _hasError
          ? Center(child: Text('Something went wrong', style: theme.body))
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              reverse: true, // Show latest messages at bottom
                              controller: _scrollController,
                              itemCount: widget.messages.length,
                              itemBuilder: (context, index) {
                                final message = widget.messages[index];
                                final isCurrentUser =
                                    message.senderUid == widget.currentUserUid;
                                final sender = widget.users[message.senderUid];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 1.0,
                                      horizontal: 5.0), // Reduced padding
                                  child: Row(
                                    mainAxisAlignment: isCurrentUser
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if (widget.isCommunity && !isCurrentUser)
                                        CircleAvatar(
                                          radius: 12, // Reduced avatar size
                                          backgroundImage: NetworkImage(
                                            sender?.profilePicture ??
                                                MockData.blankProfileAvatar,
                                          ),
                                        ),
                                      SizedBox(width: 4), // Reduced spacing
                                      Flexible(
                                        child: _buildMessageBubble(
                                            message, isCurrentUser),
                                      ),
                                      if (widget.isCommunity && isCurrentUser)
                                        SizedBox(width: 4),
                                      if (widget.isCommunity && isCurrentUser)
                                        CircleAvatar(
                                          radius: 12, // Reduced avatar size
                                          backgroundImage: NetworkImage(
                                            sender?.profilePicture ??
                                                MockData.blankProfileAvatar,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    if (_isTyping)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Typing...',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Divider(height: 1),
                    MessageComposer(
                      controller: _messageController,
                      onSend: _handleSendMessage,
                      onAttachmentTap: _handleAttachment,
                    ),
                  ],
                ),
                if (_showScrollToBottom)
                  Positioned(
                    right: 16,
                    bottom: 80,
                    child: FloatingActionButton(
                      mini: true,
                      child: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        _scrollController.animateTo(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    // TODO: Implement message sending
    setState(() {
      widget.messages.insert(
          0,
          ChatMessage(
            uid: DateTime.now().toString(),
            senderUid: widget.currentUserUid,
            message: _messageController.text,
            createdAt: DateTime.now(),
            isDelivered: true,
          ));
      _messageController.clear();
    });
  }

  void _handleAttachment() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AttachmentSheet(),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  // Add this new method
  void _showReplyUI(ChatMessage message) {
    HapticFeedback.mediumImpact();
    _slideController.forward();
    // TODO: Implement reply UI
  }
}

// New widget for message composition
class MessageComposer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachmentTap;

  const MessageComposer({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachmentTap,
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
            onTap: onSend,
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
                  Icons.videocam, 'Video', () {}, Colors.red),
              _buildAttachmentOption(
                  Icons.insert_drive_file, 'Document', () {}, Colors.blue),
              _buildAttachmentOption(
                  Icons.location_on, 'Location', () {}, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption(
      IconData icon, String label, VoidCallback onTap, Color color) {
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
  final ChatMessage message;
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
