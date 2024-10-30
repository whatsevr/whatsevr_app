import 'package:username_generator/username_generator.dart';

String getAUniqueUserName(String prefix, String type) {
  prefix = prefix.trim();
  prefix = prefix.replaceAll(' ', '');
  if (prefix.length > 8) {
    prefix = prefix.substring(0, 8);
  }
  final UsernameGenerator gen = UsernameGenerator();
  return gen.generate(
    prefix,
    suffix: '${type}_${DateTime.now().millisecondsSinceEpoch}',
    hasNumbers: false,
  );
}
