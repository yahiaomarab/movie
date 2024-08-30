import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/domain/use-case/recommended-use-case.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-states.dart';

class RecommendedCubit extends Cubit<RecommendedStates> {
  RecommendedCubit(this.recommendedUseCase)
      : super(RecommendedInitialState());

  static RecommendedCubit get(context) => BlocProvider.of(context);
  
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


}
