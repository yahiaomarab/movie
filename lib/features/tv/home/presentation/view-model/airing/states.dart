import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';

abstract class TvAiringStates {}

class InitialTvAiringStates extends TvAiringStates {}

class FetchTvAiringDataSuccessState extends TvAiringStates {
  final List<TvAiringEntity> data;
  FetchTvAiringDataSuccessState(this.data);
}

class FetchTvAiringDataFailureState extends TvAiringStates {
  final String failure;
  FetchTvAiringDataFailureState(this.failure);
}

class FetchTvAiringDataLoadingState extends TvAiringStates {}

