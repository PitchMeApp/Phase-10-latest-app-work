import 'dart:convert';

SalesPitchListModel salesPitchListModelFromJson(String str) =>
    SalesPitchListModel.fromJson(json.decode(str));

String salesPitchListModelToJson(SalesPitchListModel data) =>
    json.encode(data.toJson());

class SalesPitchListModel {
  SalesPitchListModel({
    this.message,
    this.result,
  });

  String? message;
  SalesResult? result;

  factory SalesPitchListModel.fromJson(Map<String, dynamic> json) =>
      SalesPitchListModel(
        message: json["message"],
        result: SalesResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result!.toJson(),
      };
}

class SalesResult {
  SalesResult({
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  List<SalesDoc> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  factory SalesResult.fromJson(Map<String, dynamic> json) => SalesResult(
        docs:
            List<SalesDoc>.from(json["docs"].map((x) => SalesDoc.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        page: json["page"],
        totalPages: json["totalPages"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "page": page,
        "totalPages": totalPages,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class SalesDoc {
  SalesDoc({
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
    this.userid,
    this.whocanwatch,
    this.valueamountint,
    this.fundingPhase,
    required this.user,
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
  dynamic userid;
  dynamic whocanwatch;
  dynamic valueamountint;
  dynamic fundingPhase;
  UserData user;

  factory SalesDoc.fromJson(Map<String, dynamic> json) => SalesDoc(
        id: json["_id"],
        title: json["title"],
        industry: json["industry"],
        type: json["type"],
        location: json["location"],
        valueamount: json["valueamount"],
        services: json["services"],
        servicesDetail: json["servicesDetail"],
        img1: json["img1"],
        img2: json["img2"],
        img3: json["img3"],
        img4: json["img4"],
        file: json["file"],
        vid1: json["vid1"],
        description: json["description"],
        comment: json["comment"],
        status: json["status"],
        userid: json['userid'],
        whocanwatch: json['whocanwatch'],
        valueamountint: json['valueamountint'],
        fundingPhase: json['fundingPhase'],
        user: UserData.fromJson(json["user"]),
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
        "userid": userid,
        "whocanwatch": whocanwatch,
        "valueamountint": valueamountint,
        "fundingPhase": fundingPhase,
        "user": user.toJson(),
      };
}

class UserData {
  String id;
  String username;

  int logType;

  String? uid;

  UserData({
    required this.id,
    required this.username,
    required this.logType,
    this.uid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        username: json["username"],
        logType: json["log_type"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "log_type": logType,
        "uid": uid,
      };
}
