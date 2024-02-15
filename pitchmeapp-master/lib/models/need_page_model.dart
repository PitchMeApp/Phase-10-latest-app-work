// class Doc {
//     Doc({
//         required this.id,
//         required this.type,
//         required this.name,
//     });

//     String id;
//     String type;
//     String name;

//     factory Doc.fromJson(Map<String, dynamic> json) => Doc(
//         id: json["_id"],
//         type: json["type"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "type": type,
//         "name": name,
//     };
// }