import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennz_ua/network.dart';

class NetworkCacheManager {
  // dataRequest + "_key"

  Future<bool> checkCacheExistence(String dataRequest, String key) async {
    var cacheBox = await Hive.openBox("cache");
    final dataKey = "${dataRequest}_$key";

    if (cacheBox.containsKey(dataKey)) {
      // Casting the decoded map to Map<String, dynamic>
      NetworkCache cacheByRequest = NetworkCache.fromJson(
          Map<String, dynamic>.from(await cacheBox.get(dataKey)));

      if (DateTime.now().isBefore(cacheByRequest.expired)) {
        return true;
      } else {
        await cacheBox.delete(dataKey);
      }
    }

    return false;
  }

  Future<String> readCache(String dataRequest, String key) async {
    var cacheBox = await Hive.openBox("cache");
    final dataKey = "${dataRequest}_$key";

    // Casting the decoded map to Map<String, dynamic>
    NetworkCache cacheByRequest = NetworkCache.fromJson(
        Map<String, dynamic>.from(await cacheBox.get(dataKey)));

    return cacheByRequest.data;
  }

  Future<void> writeCache(String dataRequest, String data, String key) async {
    var cacheBox = await Hive.openBox("cache");
    final dataKey = "${dataRequest}_$key";

    NetworkCache newCache = NetworkCache(
      data: data,
      expired: DateTime.now().add(
        const Duration(hours: 2),
      ),
    );

    await cacheBox.put(dataKey, newCache.toJson());
  }

  Future<void> clearCache() async {
    var cacheBox = await Hive.openBox("cache");
    await cacheBox.clear();
  }
}
