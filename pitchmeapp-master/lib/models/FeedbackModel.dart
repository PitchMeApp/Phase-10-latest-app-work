import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) =>
    FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  FeedbackModel({
    required this.message,
    required this.result,
    required this.feedback,
  });

  String message;
  Result result;
  Feedback feedback;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        message: json["message"],
        result: Result.fromJson(json["result"]),
        feedback: Feedback.fromJson(json["feedback"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result.toJson(),
        "feedback": feedback.toJson(),
      };
}

class Feedback {
  Feedback({
    required this.sender,
    required this.receiver,
    required this.title,
    required this.postid,
    required this.star,
    required this.videoStar,
    required this.description,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String sender;
  String receiver;
  String title;
  String postid;
  int star;
  int videoStar;
  String description;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        sender: json["sender"],
        receiver: json["receiver"],
        title: json["title"],
        postid: json["postid"],
        star: json["star"],
        videoStar: json["videoStar"],
        description: json["description"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "title": title,
        "postid": postid,
        "star": star,
        "videoStar": videoStar,
        "description": description,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Result {
  Result({
    required this.sender,
    required this.receiver,
    required this.postid,
    required this.title,
    required this.text,
    required this.unreadFlag,
    required this.type,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String sender;
  String receiver;
  String postid;
  String title;
  String text;
  int unreadFlag;
  int type;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        sender: json["sender"],
        receiver: json["receiver"],
        postid: json["postid"],
        title: json["title"],
        text: json["text"],
        unreadFlag: json["unread_flag"],
        type: json["type"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "postid": postid,
        "title": title,
        "text": text,
        "unread_flag": unreadFlag,
        "type": type,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
