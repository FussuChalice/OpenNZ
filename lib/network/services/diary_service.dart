import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class DiaryService {
  Future<DiaryModel> fetchDiary(
      StudentPeriodModel studentPeriod, String accessToken) async {
    final response = await http.post(
      Uri.parse("${BaseUrls.NZ_UA_API_BASE_URL}/schedule/diary"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      body: studentPeriod.toJson(),
    );

    return DiaryModel.fromJson(jsonDecode(response.body));
  }
}
