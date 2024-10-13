import 'package:movie/features/movies/similar-movie/domain/entity/similar-movie-entity.dart';

abstract class SimilarMovieStates {}

class SimilarMovieInitialState extends SimilarMovieStates {}

class GetSimilarMoviesSuccessState extends SimilarMovieStates {
  final List<SimilarMovieEntity> similarMovieEntity;
  GetSimilarMoviesSuccessState(this.similarMovieEntity);
}

class GetSimilarMovieFailureState extends SimilarMovieStates {
  final String failure;
  GetSimilarMovieFailureState(this.failure);
}

class GetSimilarMovieLoadingState extends SimilarMovieStates {}

class GetSimilarMoviePagenationLoadingState extends SimilarMovieStates {}
