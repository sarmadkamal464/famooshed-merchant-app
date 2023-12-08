class MessageUser {
  String? id;
  String? avatar_url;
  String? full_name;
  String? message;
  int? time;
  String? type;
  String count = "";

  MessageUser({this.id, this.avatar_url, this.full_name});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "uuid": id,
        "full_name": full_name,
        "avatar_url": avatar_url,
      };
}
