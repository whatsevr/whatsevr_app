import 'package:dio/dio.dart';
import 'package:whatsevr_app/config/api/client.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';
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
    required String communityUid,
    required String userUid,
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

  static Future<(int? statusCode, String? message)?> sendChatMessage({
    required String senderUid,
    String? receiverUid,
    String? communityUid,
    required String message,
    required String chatType,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/send-chat-message',
        data: {
          'sender_uid': senderUid,
          'receiver_uid': receiverUid,
          'community_uid': communityUid,
          'message': message,
          'chat_type': chatType,
        },
      );
      return (response.statusCode, response.data['message'] as String?);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> editChatMessage({
    required String messageId,
    required String userUid,
    required String newMessage,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/edit-chat-message',
        data: {
          'message_id': messageId,
          'user_uid': userUid,
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
    required String messageId,
    required String userUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/delete-chat-message',
        data: {
          'message_id': messageId,
          'user_uid': userUid,
        },
      );
      return (response.statusCode, response.data['message'] as String?);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }

  static Future<(int? statusCode, String? message)?> pinChatMessage({
    required String messageId,
    required String userUid,
  }) async {
    try {
      final Response response = await ApiClient.client.post(
        '/v1/pin-chat-message',
        data: {
          'message_id': messageId,
          'user_uid': userUid,
        },
      );
      return (response.statusCode, response.data['message'] as String?);
    } catch (e, s) {
      lowLevelCatch(e, s);
    }
    return null;
  }
}

