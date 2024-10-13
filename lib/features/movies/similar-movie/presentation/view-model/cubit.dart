import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movies/similar-movie/domain/use-case/similar-movie-use-case.dart';
import 'package:movie/features/movies/similar-movie/presentation/view-model/states.dart';

class SimilarMovieCubit extends Cubit<SimilarMovieStates> {
  final SimilarMovieUseCase similarMovieUseCase;
  SimilarMovieCubit(this.similarMovieUseCase)
      : super(SimilarMovieInitialState());
  static SimilarMovieCubit get(context) => BlocProvider.of(context);
  bool isFetchingMore = false;
  fetchSimilarMovie({int page = 1, required int id}) async {
    if (page == 1) {
      emit(GetSimilarMovieLoadingState());
    } else if (!isFetchingMore) {
      emit(GetSimilarMoviePagenationLoadingState());
      isFetchingMore = true;
    }

    final result = await similarMovieUseCase.call(page, id);
    result.fold((failure) {
      if (page == 1) {
        emit(GetSimilarMovieFailureState(failure.message));
      }
      isFetchingMore = false;
    }, (data) {
      emit(GetSimilarMoviesSuccessState(data));
      isFetchingMore = false; // Reset flag after success.
    });
  }
}
