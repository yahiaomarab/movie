import 'package:hive_flutter/adapters.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/movies/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/movies/home/domain/entity/trending/trending-entity.dart';
import 'package:movie/features/movies/similar-movie/domain/entity/similar-movie-entity.dart';
import 'package:movie/features/on-boarding/domain/entities/onboarding-entity.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';
import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';
import 'package:movie/features/tv/home/domain/entity/popular/tv-popular-entity.dart';

class HiveService {
  Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(OnBoardingEntityAdapter());
    Hive.registerAdapter(TrendingEntityAdapter());
    Hive.registerAdapter(RecommendedEntityAdapter());
    Hive.registerAdapter(SearchEntityAdapter());
    Hive.registerAdapter(SimilarMovieEntityAdapter());
    Hive.registerAdapter(TvPopularEntityAdapter());
    Hive.registerAdapter(TvAiringEntityAdapter());
    await openBoxes();
  }

  Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<OnBoardingEntity>(kOnBoardingBox),
      Hive.openBox<TrendingEntity>(KTrendingBox),
      Hive.openBox<RecommendedEntity>(KRecommendedBox),
      Hive.openBox<SearchEntity>(KSearchListBox),
      Hive.openBox<SimilarMovieEntity>(KSimilarListBox),
      Hive.openBox<TvPopularEntity>(KTvPopularBox),
      Hive.openBox<TvPopularEntity>(KTvAiringBox),
    ]);
  }
}
