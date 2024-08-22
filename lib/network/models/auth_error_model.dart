// To parse this JSON data, do
//
//     final authErrorModel = authErrorModelFromJson(jsonString);

import 'dart:convert';

AuthErrorModel authErrorModelFromJson(String str) =>
    AuthErrorModel.fromJson(json.decode(str));

String authErrorModelToJson(AuthErrorModel data) => json.encode(data.toJson());

class AuthErrorModel {
  String errorMessage;

  AuthErrorModel({
    required this.errorMessage,
  });

  factory AuthErrorModel.fromJson(Map<String, dynamic> json) => AuthErrorModel(
        errorMessage: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "error_message": errorMessage,
      };
}
