import 'dart:convert';

IndustryModel industryModelFromJson(String str) =>
    IndustryModel.fromJson(json.decode(str));

String industryModelToJson(IndustryModel data) => json.encode(data.toJson());

class IndustryModel {
  IndustryModel({
    required this.message,
    required this.result,
  });

  String message;
  IndustryResult result;

  factory IndustryModel.fromJson(Map<String, dynamic> json) => IndustryModel(
        message: json["message"],
        result: IndustryResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result.toJson(),
      };
}

class IndustryResult {
  IndustryResult({
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

  List<Doc> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  factory IndustryResult.fromJson(Map<String, dynamic> json) => IndustryResult(
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
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

class Doc {
  Doc({
    required this.id,
    required this.name,
    required this.type,
  });

  String id;
  String name;
  dynamic type;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        name: json["name"],
        type: json["type"] == null ? null : json['type'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": (type == null) ? null : type,
      };
}
