import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/tv/domain/entity/tv-entity.dart';

abstract class TvPopularLocalDataSource {
  List<TvEntity> fetchTvPopularLocalData({int page = 1});
}

class TvPopularLocalDataSourceImp extends TvPopularLocalDataSource {
  @override
  List<TvEntity> fetchTvPopularLocalData({int page = 1}) {
    int startIndex = (page - 1) * 10; 
    int endIndex = startIndex + 10;

    var box = Hive.box<TvEntity>(KTvBox);
    int length = box.values.length;

    if (startIndex >= length) {
      return [];
    }
    if (endIndex > length) {
      endIndex = length;
    }

    return box.values.toList().sublist(startIndex, endIndex);
  }
}
