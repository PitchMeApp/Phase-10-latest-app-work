import 'dart:convert';

AllUsersListModel allUsersListFromJson(String str) =>
    AllUsersListModel.fromJson(json.decode(str));

String allUsersListToJson(AllUsersListModel data) => json.encode(data.toJson());

class AllUsersListModel {
  String message;
  Result result;

  AllUsersListModel({
    required this.message,
    required this.result,
  });

  factory AllUsersListModel.fromJson(Map<String, dynamic> json) =>
      AllUsersListModel(
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result.toJson(),
      };
}

class Result {
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

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
  String id;
  String username;
  String email;
  String profilePic;
  int flag;
  int logType;
  int bot;
  String token;
  bool isSelected = false;
  dynamic hometutorial;
  dynamic salespitchtutorial;
  dynamic addsalespitchtutoria;
  dynamic dealtutorial;
  dynamic profiletutorial;

  Doc({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePic,
    required this.flag,
    required this.logType,
    required this.bot,
    required this.token,
    required this.isSelected,
    required this.addsalespitchtutoria,
    required this.dealtutorial,
    required this.hometutorial,
    required this.profiletutorial,
    required this.salespitchtutorial,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePic: json["profile_pic"],
        flag: json["flag"],
        logType: json["log_type"],
        bot: json["bot"],
        token: json["token"],
        isSelected: (json['isSelected'] == null) ? false : json['isSelected'],
        hometutorial:
            (json['hometutorial'] == null) ? false : json['hometutorial'],
        salespitchtutorial: (json['salespitchtutorial'] == null)
            ? false
            : json['salespitchtutorial'],
        addsalespitchtutoria: (json['addsalespitchtutoria'] == null)
            ? false
            : json['addsalespitchtutoria'],
        dealtutorial:
            (json['dealtutorial'] == null) ? false : json['dealtutorial'],
        profiletutorial:
            (json['profiletutorial'] == null) ? false : json['profiletutorial'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profile_pic": profilePic,
        "flag": flag,
        "log_type": logType,
        "bot": bot,
        "token": token,
        "isSelected": isSelected,
        "hometutorial": hometutorial,
        "salespitchtutorial": salespitchtutorial,
        "addsalespitchtutoria": addsalespitchtutoria,
        "dealtutorial": dealtutorial,
        "profiletutorial": profiletutorial,
      };
}
