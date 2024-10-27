import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv/domain/use-case/tv-popular-use-case.dart';
import 'package:movie/features/tv/presentation/view-model/states.dart';

class TvPopularCubit extends Cubit<TvPopularStates> {
  TvPopularCubit(this.tvPopularUseCase) : super(InitialTvPopularStates());
  static TvPopularCubit get(context) => BlocProvider.of(context);
  final TvPopularUseCase tvPopularUseCase;
  bool isFetchingMore = false;
  fetchTvPopularData({int page = 1}) async {
    if (page == 1) {
      emit(FetchTvPopularDataLoadingState());
    } else if (!isFetchingMore) {
      emit(FetchTvPopularDataPaginationLoadingState());
      isFetchingMore = true;
    }

    final result = await tvPopularUseCase.call(page);
    result.fold((failure) {
      emit(FetchTvPopularDataFailureState(failure.toString()));
      isFetchingMore = false;
    }, (data) {
      emit(FetchTvPopularDataSuccessState(data));
      isFetchingMore = false;
    });
  }
}
