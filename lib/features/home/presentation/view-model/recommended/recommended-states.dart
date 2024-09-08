import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';

abstract class RecommendedStates {}

class RecommendedInitialState extends RecommendedStates {}

class FetchRecommendedMoviesSuccessState extends RecommendedStates {
  List<RecommendedEntity> recmmendeds;
  FetchRecommendedMoviesSuccessState(this.recmmendeds);
}

class FetchRecommendedMoviesLoadingState extends RecommendedStates {}
class FetchRecommendedMoviesPagenationLoadingState extends RecommendedStates {}

class FetchRecommendedMoviesFailureState extends RecommendedStates {
  final String failure;
  FetchRecommendedMoviesFailureState(this.failure);
}

