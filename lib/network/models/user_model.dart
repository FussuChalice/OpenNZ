// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String fio;
  String accessToken;
  Avatar avatar;
  String emailHash;
  String errorMessage;
  int expiresToken;
  Permissions permissions;
  String refreshToken;
  int studentId;

  UserModel({
    required this.fio,
    required this.accessToken,
    required this.avatar,
    required this.emailHash,
    required this.errorMessage,
    required this.expiresToken,
    required this.permissions,
    required this.refreshToken,
    required this.studentId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fio: json["FIO"],
        accessToken: json["access_token"],
        avatar: Avatar.fromJson(json["avatar"]),
        emailHash: json["email_hash"],
        errorMessage: json["error_message"],
        expiresToken: json["expires_token"],
        permissions: Permissions.fromJson(json["permissions"]),
        refreshToken: json["refresh_token"],
        studentId: json["student_id"],
      );

  Map<String, dynamic> toJson() => {
        "FIO": fio,
        "access_token": accessToken,
        "avatar": avatar.toJson(),
        "email_hash": emailHash,
        "error_message": errorMessage,
        "expires_token": expiresToken,
        "permissions": permissions.toJson(),
        "refresh_token": refreshToken,
        "student_id": studentId,
      };
}

class Avatar {
  dynamic datetime;
  dynamic imageUrl;

  Avatar({
    required this.datetime,
    required this.imageUrl,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        datetime: json["datetime"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": datetime,
        "image_url": imageUrl,
      };
}

class Permissions {
  List<String> isuoNzportalChildren;

  Permissions({
    required this.isuoNzportalChildren,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
        isuoNzportalChildren:
            List<String>.from(json["isuo_nzportal_children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isuo_nzportal_children":
            List<dynamic>.from(isuoNzportalChildren.map((x) => x)),
      };
}
