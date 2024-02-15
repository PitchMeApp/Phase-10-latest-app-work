class notification {
  String? message;
  List<NotifyResult>? result;
  int? unreadNotification;

  notification({this.message, this.result, this.unreadNotification});

  notification.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <NotifyResult>[];
      json['result'].forEach((v) {
        result!.add(NotifyResult.fromJson(v));
      });
    }
    unreadNotification = json['unread_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['unread_notification'] = this.unreadNotification;
    return data;
  }
}

class NotifyResult {
  String? sId;
  String? title;
  String? text;
  int? unreadFlag;
  int? type;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? star;
  int? videoStar;
  String? senderID;

  NotifyResult({
    this.sId,
    this.title,
    this.text,
    this.unreadFlag,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.star,
    this.videoStar,
    this.iV,
    this.senderID,
  });

  NotifyResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    text = json['text'];
    unreadFlag = json['unread_flag'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    star = (json["star"] != null) ? json["star"] : 0;
    videoStar = (json["videoStar"] != null) ? json["videoStar"] : 0;
    senderID = (json['sender'] != null) ? json['sender'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['text'] = this.text;
    data['unread_flag'] = this.unreadFlag;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data["star"] = this.star;
    data["videoStar"] = this.videoStar;
    data['sender'];
    return data;
  }
}
