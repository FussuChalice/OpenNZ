import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class MarksService {
  Future<MarksByPeriodModel> getMarksByPeriod(
      StudentPeriodModel studentPeriod, String accessToken) async {
    final response = await http.post(
      Uri.parse("${BaseUrls.NZ_UA_API_BASE_URL}/schedule/student-performance"),
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      body: studentPeriod.toJson(),
    );

    return MarksByPeriodModel.fromJson(jsonDecode(response.body));
  }

  Future<MarksBySubjectModel> getMarksBySubject(
      StudentPeriodWithSubjectModel studentPeriodWithSubject,
      String accessToken) async {
    final response = await http.post(
        Uri.parse("${BaseUrls.NZ_UA_API_BASE_URL}/schedule/subject-grades"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
        body: studentPeriodWithSubject.toJson());

    return MarksBySubjectModel.fromJson(jsonDecode(response.body));
  }
}
