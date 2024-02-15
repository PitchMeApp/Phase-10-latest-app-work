import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.message,
    this.result,
  });

  String? message;
  List<Results>? result;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        message: json["message"],
        result:
            List<Results>.from(json["result"].map((x) => Results.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Results {
  Results({
    required this.id,
    required this.type,
    required this.file,
    required this.text,
    required this.flag,
    required this.createdAt,
    this.title,
    this.tags,
  });

  String id;
  int type;
  String file;
  String text;
  int flag;
  DateTime createdAt;
  dynamic title;
  dynamic tags;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        id: json["_id"],
        type: json["type"],
        file: json["file"],
        text: json["text"],
        flag: json["flag"],
        createdAt: DateTime.parse(json["createdAt"]),
        title: "title",
        tags: json['tags'],
        //json["title"] != null
        //     ? titleValues.map[json["title"]]
        //     : titleValues.map[""],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "file": file,
        "text": text,
        "flag": flag,
        "createdAt": createdAt.toIso8601String(),
        "title": "title",
        "tags": tags,
        // "title": (title != null)
        //     ? titleValues.reverse![title]
        //     : titleValues.reverse?[""],
      };
}

enum Title { TITLE }

final titleValues = EnumValues({"title": Title.TITLE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
