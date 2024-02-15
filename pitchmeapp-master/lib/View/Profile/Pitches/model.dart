import 'dart:convert';

SavedListModel savedListModelFromJson(String str) =>
    SavedListModel.fromJson(json.decode(str));

String savedListModelToJson(SavedListModel data) => json.encode(data.toJson());

class SavedListModel {
  SavedListModel({
    required this.message,
    required this.result,
  });

  String message;
  List<SavedResult> result;

  factory SavedListModel.fromJson(Map<String, dynamic> json) => SavedListModel(
        message: json["message"],
        result: List<SavedResult>.from(
            json["result"].map((x) => SavedResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class SavedResult {
  SavedResult({
    required this.id,
    required this.title,
    required this.industry,
    required this.type,
    required this.location,
    required this.valueamount,
    required this.services,
    required this.servicesDetail,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.file,
    required this.vid1,
    required this.description,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userid,
    required this.v,
    required this.whocanwatch,
    this.valueamountint,
    this.fundingPhase,
  });

  String id;
  String title;
  String industry;
  String type;
  String location;
  String valueamount;
  String services;
  String servicesDetail;
  String img1;
  String img2;
  String img3;
  String img4;
  String file;
  String vid1;
  String description;
  String comment;
  int status;
  String createdAt;
  String updatedAt;
  String userid;
  int v;
  String whocanwatch;
  dynamic valueamountint;
  dynamic fundingPhase;

  factory SavedResult.fromJson(Map<String, dynamic> json) => SavedResult(
        id: json["_id"],
        title: json["title"],
        industry: json["industry"],
        type: json["type"],
        location: json["location"],
        valueamount: json["valueamount"],
        services: json["services"],
        servicesDetail: json["servicesDetail"],
        img1: json["img1"].isNotEmpty
            ? 'https://api.salespitchapp.com/' + json["img1"]
            : json["img1"],
        img2: json["img2"].isNotEmpty
            ? 'https://api.salespitchapp.com/' + json["img2"]
            : json["img2"],
        img3: json["img3"].isNotEmpty
            ? 'https://api.salespitchapp.com/' + json["img3"]
            : json["img3"],
        img4: json["img4"].isNotEmpty
            ? 'https://api.salespitchapp.com/' + json["img4"]
            : json["img4"],
        file: json["file"].isNotEmpty
            ? 'https://api.salespitchapp.com/' + json["file"]
            : json["file"],
        vid1: json["vid1"].isNotEmpty
            ? 'http://191.101.229.245:9070/' + json["vid1"]
            : json["vid1"],
        description: json["description"],
        comment: json["comment"],
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        userid: (json['userid'] != null) ? json['userid'] : null,
        v: json["__v"],
        whocanwatch: json['whocanwatch'],
        valueamountint: json['valueamountint'],
        fundingPhase: json['fundingPhase'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "industry": industry,
        "type": type,
        "location": location,
        "valueamount": valueamount,
        "services": services,
        "servicesDetail": servicesDetail,
        "img1": img1,
        "img2": img2,
        "img3": img3,
        "img4": img4,
        "file": file,
        "vid1": vid1,
        "description": description,
        "comment": comment,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "userid": userid,
        "__v": v,
        "whocanwatch": whocanwatch,
        "valueamountint": valueamountint,
        "fundingPhase": fundingPhase,
      };
}
