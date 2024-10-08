import 'dart:convert';

import 'package:opennz_ua/extensions.dart';
import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class MarksService {
  final _networkCacheManager = NetworkCacheManager();

  Future<MarksByPeriodModel> getMarksByPeriod(StudentPeriodModel studentPeriod,
      String accessToken, bool forceUpdate) async {
    final dataRequest =
        studentPeriod.toJson().changeValueOfKey("student_id", "0").toString();
    ;

    if (await _networkCacheManager.checkCacheExistence(dataRequest, 'marks') &&
        !forceUpdate) {
      return MarksByPeriodModel.fromJson(jsonDecode(
          await _networkCacheManager.readCache(dataRequest, 'marks')));
    } else {
      final response = await http.post(
        Uri.parse(
            "${BaseUrls.NZ_UA_API_BASE_URL}/schedule/student-performance"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
        body: studentPeriod.toJson(),
      );

      await _networkCacheManager.writeCache(
          dataRequest, response.body, 'marks');

      return MarksByPeriodModel.fromJson(jsonDecode(response.body));
    }
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
