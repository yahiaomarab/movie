
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';

abstract class OnBoardingStates {}

class OnBoardingInitialState extends OnBoardingStates {}
class FetchOnBoardingSuccessState extends OnBoardingStates {
  final List<TrendingEntity> posters;

  FetchOnBoardingSuccessState(this.posters);
}

class FetchOnBoardingLoadingState extends OnBoardingStates {}

class FetchOnBoardingPaginationLoadingState extends OnBoardingStates {}

class FetchOnBoardingPaginationFailureState extends OnBoardingStates {
  final String errorMsg;
  FetchOnBoardingPaginationFailureState(this.errorMsg);
}

class FetchOnBoardingFailureState extends OnBoardingStates {
  final String errorMsg;
  FetchOnBoardingFailureState(this.errorMsg);
}
