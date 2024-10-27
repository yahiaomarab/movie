import 'package:movie/features/tv/domain/entity/tv-entity.dart';

abstract class TvPopularStates {}

class InitialTvPopularStates extends TvPopularStates {}

class FetchTvPopularDataSuccessState extends TvPopularStates {
  final List<TvEntity> data;
  FetchTvPopularDataSuccessState(this.data);
}

class FetchTvPopularDataFailureState extends TvPopularStates {
  final String failure;
  FetchTvPopularDataFailureState(this.failure);
}

class FetchTvPopularDataLoadingState extends TvPopularStates {}

class FetchTvPopularDataPaginationLoadingState extends TvPopularStates {}
