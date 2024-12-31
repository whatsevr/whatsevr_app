import 'package:whatsevr_app/utils/aes.dart';

void main() {
  final aesService = AesService();
  final encryptedText = aesService.encrypt('Hello, Baby!');
  print(encryptedText);
  print(AesService().decrypt(encryptedText));
}
