List<T> getListOfData<T>(Map<String, dynamic> data, String mapName, model) {
  List<T> listOfData = [];
  for (var trendMap in data[mapName]) {
    listOfData.add(model.fromJson(trendMap));
  }
  return listOfData;
}
