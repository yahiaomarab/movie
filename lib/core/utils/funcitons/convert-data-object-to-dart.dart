T getObjectFromJson<T>(
    Map<String, dynamic> data, String key, T Function(Map<String, dynamic>) fromJson) {
  return fromJson(data[key]);
}
