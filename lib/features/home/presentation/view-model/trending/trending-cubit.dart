import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/domain/use-case/trending-use-case.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-states.dart';

class TrendingCubit extends Cubit<TrendingStates> {
  TrendingCubit(this.trendingUseCase) : super(TrendingInitialState());

  static TrendingCubit get(context) => BlocProvider.of(context);
  final TrendingUseCase trendingUseCase;

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
