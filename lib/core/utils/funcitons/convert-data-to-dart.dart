List<T> getListOfData<T>(
    Map<String, dynamic> data, String mapName, T Function(Map<String, dynamic>) fromJson) {
  List<T> listOfData = [];
  for (var trendMap in data[mapName]) {
    listOfData.add(fromJson(trendMap));
  }
  return listOfData;
}
