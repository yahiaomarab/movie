import 'package:movie/features/tv/home/domain/entity/tv-popular-entity.dart';

abstract class TvPopularStates {}

class InitialTvPopularStates extends TvPopularStates {}

class FetchTvPopularDataSuccessState extends TvPopularStates {
  final List<TvPopularEntity> data;
  FetchTvPopularDataSuccessState(this.data);
}

class FetchTvPopularDataFailureState extends TvPopularStates {
  final String failure;
  FetchTvPopularDataFailureState(this.failure);
}

class FetchTvPopularDataLoadingState extends TvPopularStates {}

class FetchTvPopularDataPaginationLoadingState extends TvPopularStates {}
