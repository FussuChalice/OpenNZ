import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class TimetableService {
  Future<TimetableModel> getTimetable(
      StudentPeriodModel studentPeriod, String accessToken) async {
    final response = await http.post(
      Uri.parse("${BaseUrls.NZ_UA_API_BASE_URL}/schedule/timetable"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      body: studentPeriod.toJson(),
    );

    return TimetableModel.fromJson(jsonDecode(response.body));
  }
}
