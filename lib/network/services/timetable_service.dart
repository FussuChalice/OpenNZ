import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class TimetableService {
  final _networkCacheManager = NetworkCacheManager();

  Future<TimetableModel> getTimetable(StudentPeriodModel studentPeriod,
      String accessToken, bool forceUpdate) async {
    final dataRequest = studentPeriod.toJson().toString();

    // return TimetableModel.fromJson(jsonDecode(response.body));

    if (await _networkCacheManager.checkCacheExistence(
            dataRequest, 'timetable') &&
        !forceUpdate) {
      return TimetableModel.fromJson(jsonDecode(
          await _networkCacheManager.readCache(dataRequest, 'timetable')));
    } else {
      final response = await http.post(
        Uri.parse("${BaseUrls.NZ_UA_API_BASE_URL}/schedule/timetable"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
        body: studentPeriod.toJson(),
      );

      await _networkCacheManager.writeCache(
          dataRequest, response.body, 'timetable');

      return TimetableModel.fromJson(jsonDecode(response.body));
    }
  }
}
