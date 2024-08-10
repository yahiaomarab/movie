import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';


abstract class OnBoardingLocalDataSource {
  List<TrendingEntity> fetchLocalTrendingImages({int pageNumber = 1});
}

class OnBoardingLocalDataSourceImpl extends OnBoardingLocalDataSource {
  @override
  List<TrendingEntity> fetchLocalTrendingImages({int pageNumber = 1}) {
    int startIndex = pageNumber * 1;
    int endIndex = (pageNumber+1)*1;
    var box = Hive.box<TrendingEntity>(kOnBoardingBox);
    int lenght = box.values.length;
    if(startIndex >=lenght && endIndex >lenght){
      return [];
    }
    return box.values.toList();
  }
}
