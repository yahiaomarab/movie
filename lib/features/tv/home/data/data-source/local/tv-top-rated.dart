import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/tv/home/domain/entity/top-rated/tv-top-rated-entity.dart';

abstract class TvTopRatedLocalDataSource {
  List<TvTopRatedEntity> fetchTvTopRatedLocalData({int page = 1});
}

class TvTopRatedLocalDataSourceImp extends TvTopRatedLocalDataSource {
  @override
  List<TvTopRatedEntity> fetchTvTopRatedLocalData({int page = 1}) {
    int startIndex = (page - 1) * 10; 
    int endIndex = startIndex + 10;

    var box = Hive.box<TvTopRatedEntity>(KTvTopRatedBox);
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
