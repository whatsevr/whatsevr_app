import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
import 'package:whatsevr_app/config/api/response_model/chats/chat_messages.dart';
import 'package:whatsevr_app/config/api/response_model/chats/user_private_chats.dart';
import 'package:whatsevr_app/config/api/response_model/chats/user_community_chats.dart';

class ChatsApi {
  static Future<UserPrivateChatsResponse?> getUserPrivateChats({
    required String userUid,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-user-private-chats',
        queryParameters: {
          'user_uid': userUid,
          'page': page,
          'page_size': pageSize,
        },
      );
      if (response.data != null) {
        return UserPrivateChatsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<UserCommunityChatsResponse?> getUserCommunityChats({
    String? communityUid,
    String? userUid,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-user-community-chats',
        queryParameters: {
          'community_uid': communityUid,
          'user_uid': userUid,
        },
      );
      if (response.data != null) {
        return UserCommunityChatsResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<ChatMessagesResponse?> getChatMessages({
    String? communityUid,
    String? privateChatUid,
    DateTime? createdAfter,
    DateTime? createdBefore,
  }) async {
    try {
      final Response response = await ApiClient.client.get(
        '/v1/get-chat-messages',
        queryParameters: {
          if (communityUid != null) 'community_uid': communityUid,
          if (privateChatUid != null) 'private_chat_uid': privateChatUid,
          if (createdAfter != null)
            'created_after': createdAfter.toIso8601String(),
          if (createdBefore != null)
            'created_before': createdBefore.toIso8601String(),
        },
      );
      if (response.data != null) {
        return ChatMessagesResponse.fromMap(response.data);
      }
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> sendChatMessage({
    required String senderUid,
    String? privateChatUid,
    String? communityUid,
    required String message,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/send-chat-message',
        data: {
          'sender_uid': senderUid,
          'private_chat_uid': privateChatUid,
          'community_uid': communityUid,
          'message': message,
        },
      );
      return (response.statusCode, response.data['message'] as String?);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> editChatMessage({
    required String messageUid,
    required String senderUid,
    required String newMessage,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/edit-chat-message',
        data: {
          'message_uid': messageUid,
          'sender_uid': senderUid,
          'new_message': newMessage,
        },
      );
      return (response.statusCode, response.data['message'] as String?);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> deleteChatMessage({
    required String messageUid,
    required String senderUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/delete-chat-message',
        data: {
          'message_uid': messageUid,
          'sender_uid': senderUid,
        },
      );
      return (response.statusCode, response.data['message'] as String?);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> pinChatMessage({
    required String messageUid,
    required String senderUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/pin-unpin-chat-message',
        data: {
          'message_uid': messageUid,
          'sender_uid': senderUid,
        },
      );
      return (response.statusCode, response.data['message'] as String?);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}
