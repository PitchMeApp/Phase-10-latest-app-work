import 'dart:convert';

SavedLikeListModel savedLikeListModelFromJson(String str) =>
    SavedLikeListModel.fromJson(json.decode(str));

String savedLikeListModelToJson(SavedLikeListModel data) =>
    json.encode(data.toJson());

class SavedLikeListModel {
  SavedLikeListModel({
    required this.message,
    required this.result,
  });

  String message;
  List<LikeResult> result;

  factory SavedLikeListModel.fromJson(Map<String, dynamic> json) =>
      SavedLikeListModel(
        message: json["message"],
        result: List<LikeResult>.from(
            json["result"].map((x) => LikeResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class LikeResult {
  LikeResult({
    required this.id,
    required this.type,
    required this.file,
    required this.text,
    required this.flag,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  int type;
  String file;
  String text;
  int flag;
  String createdAt;
  String updatedAt;
  int v;

  factory LikeResult.fromJson(Map<String, dynamic> json) => LikeResult(
        id: json["_id"],
        type: json["type"],
        file: json["file"],
        text: json["text"],
        flag: json["flag"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "file": file,
        "text": text,
        "flag": flag,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
