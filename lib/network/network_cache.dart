class NetworkCache {
  NetworkCache({required this.data, required this.expired});

  dynamic data;
  DateTime expired;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data;
    json['expired'] = expired.toIso8601String();

    return json;
  }

  factory NetworkCache.fromJson(Map<String, dynamic> json) => NetworkCache(
        data: json["data"],
        expired: DateTime.parse(json["expired"]),
      );
}
