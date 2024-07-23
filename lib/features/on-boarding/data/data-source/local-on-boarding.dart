import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';


abstract class OnBoardingLocalDataSource {
  List<TrendingEntity> fetchLocalTrendingImages({int pageNumber = 1});
}

class OnBoardingLocalDataSourceImpl extends OnBoardingLocalDataSource {
  @override
  List<TrendingEntity> fetchLocalTrendingImages({int pageNumber = 1}) {
    var box = Hive.box<TrendingEntity>(kOnBoardingBox);
    return box.values.toList();
  }
}
