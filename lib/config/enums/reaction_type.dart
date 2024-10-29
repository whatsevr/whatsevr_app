import 'package:collection/collection.dart';
import 'package:encrypt/encrypt.dart';

enum ReactionType {
  like('👍', 'like', 'liked'),
  love('❤️', 'love', 'loved'),
  haha('😂', 'haha', 'laughed'),
  wow('😮', 'wow', 'amazed'),
  sad('😢', 'sad', 'saddened'),
  angry('😠', 'angry', 'angered');

  final String emoji;
  final String reactionType;
  final String adjective;

  const ReactionType(this.emoji, this.reactionType, this.adjective);

  static List<String> get names =>
      ReactionType.values.map((e) => e.name).toList();

  static ReactionType? fromName(String? name) =>
      ReactionType.values.firstWhereOrNull((e) => e.name == name);
}
