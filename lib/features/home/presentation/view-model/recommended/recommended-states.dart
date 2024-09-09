import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';

abstract class RecommendedStates {}

class RecommendedInitialState extends RecommendedStates {}

class FetchRecommendedMoviesLoadingState extends RecommendedStates {}

class FetchRecommendedMoviesPagenationLoadingState extends RecommendedStates {}

class FetchRecommendedMoviesSuccessState extends RecommendedStates {
  final List<RecommendedEntity> recommendeds;

  FetchRecommendedMoviesSuccessState(this.recommendeds);
}

class FetchRecommendedMoviesFailureState extends RecommendedStates {
  final String failure;

  FetchRecommendedMoviesFailureState(this.failure);
}
