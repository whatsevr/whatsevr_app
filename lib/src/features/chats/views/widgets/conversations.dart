import 'package:flutter/material.dart';
import 'package:whatsevr_app/config/mocks/mocks.dart';
import 'package:whatsevr_app/src/features/chats/models/message.dart';
import 'package:whatsevr_app/src/features/chats/models/user.dart';

final String defaultProfilePicture = 'https://dxvbdpxfzdpgiscphujy.supabase.co/storage/v1/object/public/assets/blank-profile.jpg';

class Conversations extends StatelessWidget {
  final List<ChatMessage> messages = List.generate(
    10,
    (index) => ChatMessage( 
      uid: '$index',
      senderUid: index % 2 == 0 ? 'user1' : 'user2',
      message: 'This is message number $index',
      createdAt: DateTime.now().subtract(Duration(minutes: index * 5)),
    ),
  );

  final String currentUserUid = 'user1'; // Define the current user's UID
  final bool isGroup;

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
 
  Conversations({this.isGroup = true}); // Add this parameter
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                isGroup
                    ? users[currentUserUid]?.profilePicture ?? MockData.blankCommunityAvatar 
                    : users[currentUserUid]?.profilePicture ?? MockData.blankProfileAvatar,  // Contact avatar URL
              ),
              radius: 18, 
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isGroup ? 'Group Name' : 'Contact Name',
                    style: TextStyle( 
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    isGroup ? '5 members' : 'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: isGroup ? Colors.grey : Colors.green,
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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded( 
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isCurrentUser = message.senderUid == currentUserUid;
                final sender = users[message.senderUid];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0), // Reduced padding
                  child: Row(
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (isGroup && !isCurrentUser)
                        CircleAvatar(
                          radius: 12, // Reduced avatar size
                          backgroundImage: NetworkImage(
                            sender?.profilePicture ?? defaultProfilePicture,
                          ),
                        ),
                      SizedBox(width: 4), // Reduced spacing
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduced padding
                          decoration: BoxDecoration(
                            color: isCurrentUser ? Colors.blueAccent : Colors.white,
                            borderRadius: BorderRadius.circular(12), // Adjusted radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isGroup && !isCurrentUser)
                                Text(
                                  sender?.name ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 11, // Decreased font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              SizedBox(height: 1),
                              Text(
                                message.message ?? '',
                                style: TextStyle(
                                  color: isCurrentUser ? Colors.white : Colors.black87,
                                  fontSize: 13, // Decreased font size
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
                                      Icons.check,
                                      size: 12, // Reduced icon size
                                      color: Colors.grey[500],
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isGroup && isCurrentUser)
                        SizedBox(width: 4),
                      if (isGroup && isCurrentUser)
                        CircleAvatar(
                          radius: 12, // Reduced avatar size
                          backgroundImage: NetworkImage(
                            sender?.profilePicture ?? defaultProfilePicture,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), // Reduced padding
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.insert_emoticon, color: Colors.grey, size: 20), // Reduced icon size
                  onPressed: () {
                    // Handle emoji selection
                  },
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10), // Reduced padding
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20), // Adjusted radius
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 14), // Decreased font size
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file, color: Colors.grey, size: 20), // Reduced icon size
                  onPressed: () {
                    // Handle file attachment
                  },
                ),
                GestureDetector(
                  onTap: () {
                    // Handle send message
                  },
                  child: CircleAvatar(
                    radius: 18, // Reduced size
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.send, color: Colors.white, size: 16), // Reduced icon size
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
