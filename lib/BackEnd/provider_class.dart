import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../components/AppConstants.dart';
import '../components/AppMessage.dart';
import 'class_models.dart';

///=================================================================
class StoryProviderClass extends ChangeNotifier {
  DataHandle<Story> story = DataHandle(
    result: AppMessage.initial,
  );

  DataHandle<Encouragement> quote = DataHandle(
    result: AppMessage.initial,
  );

  List<Story> favoriteStories = [];

  int lastIndex = 1;
  DateTime lastDate = DateTime.now().subtract(const Duration(days: 1));

  setPreferences({required int newIndex, required DateTime date}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (date.isAfter(lastDate.add(const Duration(days: 1))) &&
        newIndex + 2 > lastIndex) {
      pref.setInt('lastIndex', newIndex + 2);
      pref.setString('lastDate', date.toString());
      lastIndex = newIndex + 2;
      lastDate = date;
    } else {
      print('Oops not today XD');
    }
    notifyListeners();
  }

  getPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    lastIndex = pref.getInt('lastIndex') ?? 1;
    lastDate = (pref.getString('lastDate') == null
        ? DateTime.now().subtract(const Duration(days: 1))
        : DateTime.parse(pref.getString('lastDate')!)!)!;
    notifyListeners();
  }

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
        story.result = story.data!.title!.isEmpty
            ? AppMessage.serverExceptions
            : AppMessage.loaded;
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

  ///get order=============================================================================================================================================================================================================
  Future getQuote({required String text}) async {
    debugPrint('getting Quote ... !');
    try {
      quote.result = AppMessage.loading;
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
        quote.data = Encouragement.fromJson(
            jsonDecode(response.body)['candidates'][0]['content']['parts'][0]);
        quote.result = AppMessage.loaded;

        print('quote.dat: ${quote.data?.encouragement}');
        notifyListeners();

        return AppMessage.loaded;
      } else if (response.statusCode == 401) {
        quote.result = AppMessage.unAuthorized;
        notifyListeners();
        return AppMessage.unAuthorized;
      } else {
        quote.result = AppMessage.serverExceptions;
        notifyListeners();
        return AppMessage.serverExceptions;
      }
    } catch (e) {
      if (e is FormatException) {
        quote.result = AppMessage.formatException;
        notifyListeners();
        return AppMessage.formatException;
      } else if (e is SocketException) {
        quote.result = AppMessage.socketException;
        notifyListeners();
        return AppMessage.socketException;
      } else if (e is TimeoutException) {
        quote.result = AppMessage.timeoutException;
        notifyListeners();
        return AppMessage.timeoutException;
      } else {
        quote.result = AppMessage.serverExceptions;
        notifyListeners();
        return AppMessage.serverExceptions;
      }
    }
  }

  ///====================================================================================================
  Future getFavoriteStories() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List temp = json.decode(pref.getString('favList')??'[]') as List<dynamic>;
   favoriteStories = temp.map((e)=> Story.fromJson(e)).toList();
    notifyListeners();
  }

  ///====================================================================================================
  Future setFavoriteStory() async {
    List<Story> temp = [];
    temp = favoriteStories;
    favoriteStories = [];
    temp.add(story.data!);
    favoriteStories = temp;
    notifyListeners();

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('favList', jsonEncode(favoriteStories));
  }

  ///====================================================================================================
  Future removeFavoriteStory({Story? theStory}) async {
    List<Story> temp = [];
    temp = favoriteStories;
    favoriteStories = [];
    temp.remove(theStory??story.data);
    favoriteStories = temp;
    notifyListeners();

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('favList', jsonEncode(favoriteStories));
  }
}
