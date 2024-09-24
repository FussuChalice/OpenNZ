import 'dart:convert';

import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class GithubReleasesService {
  Future<List<GithubReleaseModel>> getListOfReleases(
      String user, String repo) async {
    final response = await http.get(Uri.parse(
        "${BaseUrls.GITHUB_API_BASE_URL}/repos/$user/$repo/releases"));

    List<dynamic> parsedResult = jsonDecode(response.body);
    List<GithubReleaseModel> result = [];
    for (var release in parsedResult) {
      result.add(GithubReleaseModel.fromJson(release));
    }

    return result;
  }
}
