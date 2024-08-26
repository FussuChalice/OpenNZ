import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennz_ua/network.dart';

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel(
    fio: "",
    accessToken: "",
    avatar: Avatar(datetime: null, imageUrl: ""),
    emailHash: "",
    errorMessage: "",
    expiresToken: 0,
    permissions: Permissions(isuoNzportalChildren: []),
    refreshToken: "",
    studentId: 0,
  );

  Future<void> fetchUser() async {
    try {
      var box = await Hive.openBox("auth_data");
      AuthByPasswordCredentialModel credentials =
          authByPasswordCredentialModelFromJson(box.get("credentials"));

      final data = await AuthService().authByLoginAndPassword(credentials);
      data.fold((userData) => {user = userData}, (error) => {});
    } finally {
      notifyListeners();
    }
  }
}
