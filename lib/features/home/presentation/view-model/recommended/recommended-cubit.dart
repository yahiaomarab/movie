import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/domain/use-case/recommended-use-case.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-states.dart';

class RecommendedCubit extends Cubit<RecommendedStates> {
  RecommendedCubit(this.recommendedUseCase) : super(RecommendedInitialState());

  static RecommendedCubit get(context) => BlocProvider.of(context);
  final RecommendedUseCase recommendedUseCase;
  bool isFetchingMore = false;
  Future<void> fetchRecommendedMovies({int page = 1}) async {
    if (page == 1) {
      emit(FetchRecommendedMoviesLoadingState());
    } else if (!isFetchingMore) {
      emit(FetchRecommendedMoviesPagenationLoadingState());
      isFetchingMore = true; 
    }

    final result = await recommendedUseCase.call(page);
    result.fold((failure) {
      if (page == 1) {
        emit(FetchRecommendedMoviesFailureState(failure.message));
      }
      isFetchingMore = false; // Reset flag after failure.
    }, (data) {
      emit(FetchRecommendedMoviesSuccessState(data));
      isFetchingMore = false; // Reset flag after success.
    });
  }
}
