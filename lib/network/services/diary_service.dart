import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class DiaryService {
  static const String nzBaseURL = "https://api-mobile.nz.ua/v1";

  Future<DiaryResultModel> fetchDiary(
      StudentPeriodModel studentPeriod, String accessToken) async {
    final response = await http.post(
      Uri.parse("$nzBaseURL/schedule/diary"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      body: studentPeriod.toJson(),
    );

    return DiaryResultModel.fromJson(jsonDecode(response.body));
  }
}
