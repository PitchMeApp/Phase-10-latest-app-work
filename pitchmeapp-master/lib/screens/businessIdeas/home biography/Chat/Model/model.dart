import 'dart:convert';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  List<Message> messages;

  ChatListModel({
    required this.messages,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  Chat chat;
  ChatUser? user;
  MessageMessage? message;
  int unread;

  Message({
    required this.chat,
    required this.user,
    this.message,
    required this.unread,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      chat: Chat.fromJson(json["chat"]),
      user: json["user"] == null ? null : ChatUser.fromJson(json["user"]),
      message: json["message"] == null
          ? null
          : MessageMessage.fromJson(json["message"]),
      unread: json['unread']);

  Map<String, dynamic> toJson() => {
        "chat": chat.toJson(),
        "user": user!.toJson(),
        "message": message?.toJson(),
        "unread": unread,
      };
}

class Chat {
  String id;
  dynamic sendorid;
  String recieverid;
  String createdAt;
  String updatedAt;
  int v;

  Chat({
    required this.id,
    required this.sendorid,
    required this.recieverid,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        sendorid: (json["sendorid"] == null) ? null : json["sendorid"],
        recieverid: json["recieverid"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sendorid": sendorid,
        "recieverid": recieverid,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class ChatUser {
  String id;
  String username;
  String email;
  dynamic password;
  String profilePic;
  int emailVerify;
  int flag;
  int type;
  int logType;
  dynamic registerToken;
  String createdAt;
  String updatedAt;
  int v;

  ChatUser({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.emailVerify,
    required this.flag,
    required this.type,
    required this.logType,
    required this.registerToken,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: (json["password"]) != null ? json["password"] : null,
        profilePic: json["profile_pic"].toString().isNotEmpty
            ? 'https://api.salespitchapp.com/' + json["profile_pic"]
            : json["profile_pic"],
        emailVerify: json["email_verify"],
        flag: json["flag"],
        type: json["type"],
        logType: json["log_type"],
        registerToken:
            (json["register_token"]) != null ? json["register_token"] : null,
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "profile_pic": profilePic,
        "email_verify": emailVerify,
        "flag": flag,
        "type": type,
        "log_type": logType,
        "register_token": registerToken,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class MessageMessage {
  String id;
  String sendorid;
  String chatid;
  String message;
  String image;
  String voice;
  String video;
  bool read;
  String createdAt;
  String updatedAt;
  int v;
  int time;

  MessageMessage({
    required this.id,
    required this.sendorid,
    required this.chatid,
    required this.message,
    required this.image,
    required this.voice,
    required this.video,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.time,
  });

  factory MessageMessage.fromJson(Map<String, dynamic> json) => MessageMessage(
      id: json["_id"],
      sendorid: json["sendorid"],
      chatid: json["chatid"],
      message: json["message"],
      image: json["image"],
      voice: json["voice"],
      video: json["video"],
      read: json["read"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      v: json["__v"],
      time: json['time']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sendorid": sendorid,
        "chatid": chatid,
        "message": message,
        "image": image,
        "voice": voice,
        "video": video,
        "read": read,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "time": time,
      };
}
