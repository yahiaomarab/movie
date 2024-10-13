import 'package:movie/features/movies/home/domain/entity/trending/trending-entity.dart';

abstract class TrendingStates {}

class TrendingInitialState extends TrendingStates {}



class FetchTrendingMoviesSuccessState extends TrendingStates {
  List<TrendingEntity> trends;
  FetchTrendingMoviesSuccessState(this.trends);
}

class FetchTrendingMoviesLoadingState extends TrendingStates {}

class FetchTrendingMoviesFailureState extends TrendingStates {
  final String failure;
  FetchTrendingMoviesFailureState(this.failure);
}
