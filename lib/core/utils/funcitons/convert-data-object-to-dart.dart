T getObjectFromJson<T>(
    Map<String, dynamic> data, String key, T Function(Map<String, dynamic>) fromJson) {
  // Check if the key exists and is not null
  if (data[key] == null) {
    throw Exception('Key "$key" is not found or is null in the JSON data');
  }
  if (data[key] is! Map<String, dynamic>) {
    throw Exception('Value for key "$key" is not a Map<String, dynamic>');
  }

  return fromJson(data[key] as Map<String, dynamic>);
}
