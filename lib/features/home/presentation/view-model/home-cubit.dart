import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/domain/use-case/recommended-use-case.dart';
import 'package:movie/features/home/domain/use-case/trending-use-case.dart';
import 'package:movie/features/home/presentation/view-model/home-states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.trendingUseCase, this.recommendedUseCase)
      : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  final TrendingUseCase trendingUseCase;
  final RecommendedUseCase recommendedUseCase;

  void fetchRecommendedMovies({int page = 1}) async {
    emit(FetchRecommendedMoviesLoadingState());
    final result = await recommendedUseCase.call(page);
    result.fold(
      (failure) {
        emit(FetchRecommendedMoviesFailureState(failure.message));
      },
      (data) {
        emit(FetchRecommendedMoviesSuccessState(data));
      },
    );
  }

   void fetchTrendingMovies() async {
    emit(FetchTrendingMoviesLoadingState());
    final result = await trendingUseCase.call();
    result.fold(
      (failure) {
        emit(FetchTrendingMoviesFailureState(failure.message));
      },
      (data) {
        emit(FetchTrendingMoviesSuccessState(data));
      },
    );
  }
}
