import 'package:movie/features/tv/home/domain/entity/top-rated/tv-top-rated-entity.dart';

abstract class TvTopRatedStates{}
class TvTopRatedInitialState extends TvTopRatedStates{}

class InitialTvTopRatedStates extends TvTopRatedStates {}

class FetchTvTopRatedDataSuccessState extends TvTopRatedStates {
  final List<TvTopRatedEntity> data;
  FetchTvTopRatedDataSuccessState(this.data);
}

class FetchTvTopRatedDataFailureState extends TvTopRatedStates {
  final String failure;
  FetchTvTopRatedDataFailureState(this.failure);
}

class FetchTvTopRatedDataLoadingState extends TvTopRatedStates {}

class FetchTvTopRatedDataPaginationLoadingState extends TvTopRatedStates {}
