extension MapExtension on Map {
  Map changeValueOfKey(String key, dynamic value) {
    this[key] = value;
    return this;
  }
}
