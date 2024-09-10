import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class MissedLessonsService {
  Future<MissedLessonsModel> fetchMissedLessons(
      StudentPeriodModel studentPeriod, String accessToken) async {
    final response = await http.post(
      Uri.parse("${BaseUrls.NZ_UA_API_BASE_URL}/schedule/missed-lessons"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      body: studentPeriod.toJson(),
    );

    return MissedLessonsModel.fromJson(jsonDecode(response.body));
  }
}
