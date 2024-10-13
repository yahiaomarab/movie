import 'package:movie/features/movies/home-details/data/models/movie-model.dart';

abstract class HomeDetailsStates{}
class InitialHomeDetailsState extends HomeDetailsStates{}
class FetchHomeDetailsLoadingState extends HomeDetailsStates{}
class FetchHomeDetailsFailureState extends HomeDetailsStates{
  final String failure;
  FetchHomeDetailsFailureState(this.failure);
}
class FetchHomeDetailsSuccessState extends HomeDetailsStates{
  final MovieModel movieModel;
  FetchHomeDetailsSuccessState(this.movieModel);
}