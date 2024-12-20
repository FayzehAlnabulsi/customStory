import 'package:custom_story/BackEnd/provider_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ChangeNotifierProvider<StoryProviderClass> storyProvider =
    ChangeNotifierProvider((ref) {
  return StoryProviderClass();
});
