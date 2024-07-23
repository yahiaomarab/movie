 import 'package:hive/hive.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';

 void saveData(List<TrendingEntity> posters) {
    var box = Hive.box<TrendingEntity>('kOnBoardingBox');
    box.addAll(posters);
  }