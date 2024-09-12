import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';
import 'package:movie/features/home/domain/use-case/trending-use-case.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-states.dart';
class TrendingCubit extends Cubit<TrendingStates> {
  TrendingCubit(this.trendingUseCase) : super(TrendingInitialState());

  static TrendingCubit get(context) => BlocProvider.of(context);

  final TrendingUseCase trendingUseCase;
  List<TrendingEntity> _cachedTrends = [];

  void fetchTrendingMovies() async {
    if (_cachedTrends.isNotEmpty) {
      // Emit success with cached data instead of fetching again
      emit(FetchTrendingMoviesSuccessState(_cachedTrends));
      return;
    }

    emit(FetchTrendingMoviesLoadingState());
    final result = await trendingUseCase.call();
    result.fold(
      (failure) {
        emit(FetchTrendingMoviesFailureState(failure.message));
      },
      (data) {
        _cachedTrends = data;  // Cache the data to avoid refetching
        emit(FetchTrendingMoviesSuccessState(data));
      },
    );
  }
}

