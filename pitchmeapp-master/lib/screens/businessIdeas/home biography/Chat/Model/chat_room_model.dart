// To parse this JSON data, do
//
//     final chatRoomModel = chatRoomModelFromJson(jsonString);

import 'dart:convert';

ChatRoomModel chatRoomModelFromJson(String str) =>
    ChatRoomModel.fromJson(json.decode(str));

String chatRoomModelToJson(ChatRoomModel data) => json.encode(data.toJson());

class ChatRoomModel {
  RoomMessage message;
  String roomid;

  ChatRoomModel({
    required this.message,
    required this.roomid,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        message: RoomMessage.fromJson(json["message"]),
        roomid: json["roomid"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "roomid": roomid,
      };
}

class RoomMessage {
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

  RoomMessage({
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

  factory RoomMessage.fromJson(Map<String, dynamic> json) => RoomMessage(
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
        time: json["time"],
      );

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
