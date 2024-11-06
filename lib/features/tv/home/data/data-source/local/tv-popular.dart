import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/tv/home/domain/entity/tv-popular-entity.dart';

abstract class TvPopularLocalDataSource {
  List<TvPopularEntity> fetchTvPopularLocalData({int page = 1});
}

class TvPopularLocalDataSourceImp extends TvPopularLocalDataSource {
  @override
  List<TvPopularEntity> fetchTvPopularLocalData({int page = 1}) {
    int startIndex = (page - 1) * 10; 
    int endIndex = startIndex + 10;

    var box = Hive.box<TvPopularEntity>(KTvBox);
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
