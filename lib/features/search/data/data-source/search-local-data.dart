import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';

abstract class SearchLocalData {
  List<SearchEntity> fetchSearchLocalData({int page = 1,required String query});
}

class SearchLocalDataImpl extends SearchLocalData {
  @override
  List<SearchEntity> fetchSearchLocalData({int page = 1,required String query}) {
    int startIndex = (page - 1) * 10;
    int endIndex = page * 10;
    var box = Hive.box<SearchEntity>(KSearchListBox);
    int length = box.values.length;
    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }
}
