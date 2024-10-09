List<T> getListOfData<T>(
  Map<String, dynamic> data, 
  String mapName, 
  T Function(Map<String, dynamic>) fromJson
) {
  List<T> listOfData = [];

  // Check if the data contains the specified mapName and if it is a List
  if (data.containsKey(mapName) && data[mapName] is List) {
    for (var trendMap in data[mapName]) {
      // Check if each item is a Map and apply fromJson
      if (trendMap is Map<String, dynamic>) {
        listOfData.add(fromJson(trendMap));
      }
    }
  }

  return listOfData;
}
