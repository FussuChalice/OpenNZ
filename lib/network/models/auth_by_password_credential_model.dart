// To parse this JSON data, do
//
//     final authByPasswordCredentialModel = authByPasswordCredentialModelFromJson(jsonString);

import 'dart:convert';

AuthByPasswordCredentialModel authByPasswordCredentialModelFromJson(
        String str) =>
    AuthByPasswordCredentialModel.fromJson(json.decode(str));

String authByPasswordCredentialModelToJson(
        AuthByPasswordCredentialModel data) =>
    json.encode(data.toJson());

class AuthByPasswordCredentialModel {
  String password;
  String username;

  AuthByPasswordCredentialModel({
    required this.password,
    required this.username,
  });

  factory AuthByPasswordCredentialModel.fromJson(Map<String, dynamic> json) =>
      AuthByPasswordCredentialModel(
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "username": username,
      };
}
