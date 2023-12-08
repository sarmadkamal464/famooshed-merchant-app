// To parse this JSON data, do
//
//     final uploadImageResponse = uploadImageResponseFromJson(jsonString);

import 'dart:convert';

UploadImageResponse uploadImageResponseFromJson(String str) =>
    UploadImageResponse.fromJson(json.decode(str));

String uploadImageResponseToJson(UploadImageResponse data) =>
    json.encode(data.toJson());

class UploadImageResponse {
  String error;
  String filename;
  int id;
  DateTime date;

  UploadImageResponse({
    required this.error,
    required this.filename,
    required this.id,
    required this.date,
  });

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      UploadImageResponse(
        error: json["error"],
        filename: json["filename"],
        id: json["id"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "filename": filename,
        "id": id,
        "date": date.toIso8601String(),
      };
}
