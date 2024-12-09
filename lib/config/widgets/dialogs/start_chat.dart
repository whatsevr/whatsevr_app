import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:whatsevr_app/config/api/external/models/business_validation_exception.dart';

void startChat({
  String? currentUserUid,
  String? otherUserUid,
  String? communityUid,
}) {
  try {
    assert(
      (currentUserUid != null && otherUserUid != null) || communityUid != null,
      'Either provide both currentUserUid and otherUserUid or provide communityUid',
    );
     SmartDialog.showLoading(msg: 'Starting chat...');
    if (currentUserUid != null && otherUserUid != null) {
     
    }
    if (communityUid != null) {
      
    }
  } catch (e, s) {
    highLevelCatch(e, s);
  }
}
