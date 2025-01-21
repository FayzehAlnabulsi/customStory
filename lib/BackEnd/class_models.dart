import 'dart:convert';

enum NotificationType { alert, order }

class DataHandle<T> {
  T? data;
  String? url;
  String result;
  DataHandle({this.data, this.url, required this.result});
}

//==============================================================================================================================================================================================================

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  String? title;
  String? story;
  List<String>? moral;

  Story({
    this.title,
    this.story,
    this.moral,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      title: json["title"],
      story: json["story"],
      moral: json["benefits"] == null
          ? []
          : List<String>.from(json["benefits"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "story": story,
        "benefits": moral == null ? [] : List<dynamic>.from(moral!.map((x) => x)),
      };
}

class Encouragement {
  String? encouragement;

  Encouragement({
    this.encouragement,
  });

  factory Encouragement.fromJson(Map<String, dynamic> json) {
    return Encouragement(
      encouragement: json["text"],
    );
  }
}
