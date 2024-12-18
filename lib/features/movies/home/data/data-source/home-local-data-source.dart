import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/movies/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/movies/home/domain/entity/trending/trending-entity.dart';

abstract class HomeLocalDataSource {
  List<TrendingEntity> fetchTrendingDataLocal();
  List<RecommendedEntity> fetchRecommendedDataLocal({int page = 1});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<RecommendedEntity> fetchRecommendedDataLocal({int page = 1}) {
    int startIndex = (page - 1) * 10; 
    int endIndex = startIndex + 10;
    var box = Hive.box<RecommendedEntity>(KRecommendedBox);
    int length = box.values.length;
     if (startIndex >= length) {
      return [];
    }
    if (endIndex > length) {
      endIndex = length;
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<TrendingEntity> fetchTrendingDataLocal() {
    var box = Hive.box<TrendingEntity>(KTrendingBox);
    return box.values.toList();
  }
}
