import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class DiaryService {
  final _networkCacheManager = NetworkCacheManager();

  Future<DiaryModel> fetchDiary(StudentPeriodModel studentPeriod,
      String accessToken, bool forceUpdate) async {
    final dataRequest = studentPeriod.toJson().toString();
    if (await _networkCacheManager.checkCacheExistence(dataRequest, 'diary') &&
        !forceUpdate) {
      return DiaryModel.fromJson(jsonDecode(
          await _networkCacheManager.readCache(dataRequest, 'diary')));
    } else {
      final response = await http.post(
        Uri.parse("${BaseUrls.NZ_UA_API_BASE_URL}/schedule/diary"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
        body: studentPeriod.toJson(),
      );

      await _networkCacheManager.writeCache(
          dataRequest, response.body, 'diary');

      return DiaryModel.fromJson(jsonDecode(response.body));
    }
  }
}
