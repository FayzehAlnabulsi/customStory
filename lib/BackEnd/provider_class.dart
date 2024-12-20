import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../components/AppConstants.dart';
import '../components/AppMessage.dart';
import 'class_models.dart';

///=================================================================
class StoryProviderClass extends ChangeNotifier {
  DataHandle<Story> story = DataHandle(
    result: AppMessage.initial,
  );

  ///get order=============================================================================================================================================================================================================
  Future getStory({required String text}) async {
    debugPrint('getting Story ... !');
    try {
      story.result = AppMessage.loading;
      notifyListeners();

      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/${AppConstants.geminiModelVersion}:generateContent?key=${AppConstants.geminiApiKey}',
        ),
        headers: AppMessage.headers,
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": text},
              ]
            }
          ]
        }),
      );

      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        story.data = storyFromJson(
            '{${jsonDecode(response.body)['candidates'][0]['content']['parts'][0]['text'].substring(12).replaceAll('```', '').trim()}');
        story.result = AppMessage.loaded;
        notifyListeners();

        return AppMessage.loaded;
      } else if (response.statusCode == 401) {
        story.result = AppMessage.unAuthorized;
        notifyListeners();
        return AppMessage.unAuthorized;
      } else {
        story.result = AppMessage.serverExceptions;
        notifyListeners();
        return AppMessage.serverExceptions;
      }
    } catch (e) {
      if (e is FormatException) {
        story.result = AppMessage.formatException;
        notifyListeners();
        return AppMessage.formatException;
      } else if (e is SocketException) {
        story.result = AppMessage.socketException;
        notifyListeners();
        return AppMessage.socketException;
      } else if (e is TimeoutException) {
        story.result = AppMessage.timeoutException;
        notifyListeners();
        return AppMessage.timeoutException;
      } else {
        story.result = AppMessage.serverExceptions;
        notifyListeners();
        return AppMessage.serverExceptions;
      }
    }
  }
}
