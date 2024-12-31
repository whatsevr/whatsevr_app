import 'dart:convert';
import 'package:encrypt/encrypt.dart';

class AesService {
  late final Key _key;
  late final IV _iv;

  AesService([String? encryptionKey]) {
    // Base64 decode the encryption key
    final keyString =
        encryptionKey ?? 'ZSLBTlLJf8yrOAojKmcYQTyA6aS4WK3Quv1yCWGU1rI/6VAQIh8y';
    final keyBytes = base64.decode(keyString);

    // Ensure key is exactly 32 bytes (256 bits) for AES-256
    if (keyBytes.length < 32) {
      throw ArgumentError(
          'Encryption key must be at least 32 bytes when decoded',);
    }
    final normalized32ByteKey = keyBytes.sublist(0, 32);
    _key = Key(normalized32ByteKey);

    // Generate a unique IV using the last 16 bytes of the key
    // This ensures IV is different from the key portion we use
    final ivBytes = keyBytes.sublist(keyBytes.length - 16);
    _iv = IV(ivBytes);
  }

  String encrypt(String plainText) {
    if (plainText.isEmpty) {
      throw ArgumentError('Plain text cannot be empty');
    }

    try {
      final encryptService = Encrypter(AES(_key, mode: AESMode.cbc));
      final encryptedText = encryptService.encrypt(plainText, iv: _iv);
      return encryptedText.base64;
    } catch (e) {
      throw Exception('Encryption failed: ${e.toString()}');
    }
  }

  String decrypt(String encryptedText) {
    if (encryptedText.isEmpty) {
      throw ArgumentError('Encrypted text cannot be empty');
    }

    try {
      final encryptService = Encrypter(AES(_key, mode: AESMode.cbc));
      final decryptedText =
          encryptService.decrypt(Encrypted.fromBase64(encryptedText), iv: _iv);
      return decryptedText;
    } catch (e) {
      throw Exception('Decryption failed: ${e.toString()}');
    }
  }
}
