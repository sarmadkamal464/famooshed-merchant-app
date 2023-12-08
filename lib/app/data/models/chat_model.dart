class ResponseChatMessages {
  String error;
  int unread;
  List<ChatMessages> messages;
  ResponseChatMessages(
      {required this.error, required this.messages, required this.unread});
  factory ResponseChatMessages.fromJson(Map<String, dynamic> json) {
    List<ChatMessages> m = [];
    if (json['messages'] != null) {
      var items = json['messages'];
      var t = items.map((f) => ChatMessages.fromJson(f)).toList();
      m = t.cast<ChatMessages>().toList();
    }
    var _unread = 0;
    // if (m != null)
    for (var item in m) if (item.read == 'false') _unread++;
    return ResponseChatMessages(
      error: json['error'].toString(),
      messages: m,
      unread: _unread,
    );
  }
}

class ChatMessages {
  int id;
  String date;
  String text;
  String author;
  String delivered;
  String read;

  ChatMessages(
      {required this.id,
      required this.date,
      required this.text,
      required this.author,
      required this.delivered,
      required this.read});
  factory ChatMessages.fromJson(Map<String, dynamic> json) {
    return ChatMessages(
      id: int.parse(json['id'].toString()),
      date: json['created_at'].toString(),
      text: json['text'].toString(),
      author: json['author'].toString(),
      delivered: json['delivered'].toString(),
      read: json['read'].toString(),
    );
  }
}

class ChatUser {
  int? id;
  String? name;
  String? image;
  int? count;
  int? unread;

  ChatUser({
    this.id,
    this.name,
    this.image,
    this.count,
    this.unread,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        count: json["count"],
        unread: json["unread"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "count": count,
        "unread": unread,
      };
}
