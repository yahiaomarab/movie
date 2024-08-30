import 'package:hive_flutter/adapters.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';
import 'package:movie/features/on-boarding/domain/entities/onboarding-entity.dart';

class HiveService {
  Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(OnBoardingEntityAdapter());
    Hive.registerAdapter(TrendingEntityAdapter());
    Hive.registerAdapter(RecommendedEntityAdapter());

    await openBoxes();
  }

  Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<OnBoardingEntity>(kOnBoardingBox),
      Hive.openBox<TrendingEntity>(KTrendingBox),
      Hive.openBox<RecommendedEntity>(KRecommendedBox)
    ]);
  }
}