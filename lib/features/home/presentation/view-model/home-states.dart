import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class FetchRecommendedMoviesSuccessState extends HomeStates {
  List<RecommendedEntity> recmmendeds;
  FetchRecommendedMoviesSuccessState(this.recmmendeds);
}

class FetchRecommendedMoviesLoadingState extends HomeStates {}

class FetchRecommendedMoviesFailureState extends HomeStates {
  final String failure;
  FetchRecommendedMoviesFailureState(this.failure);
}

class FetchTrendingMoviesSuccessState extends HomeStates {
  List<TrendingEntity> trends;
  FetchTrendingMoviesSuccessState(this.trends);
}

class FetchTrendingMoviesLoadingState extends HomeStates {}

class FetchTrendingMoviesFailureState extends HomeStates {
  final String failure;
  FetchTrendingMoviesFailureState(this.failure);
}
