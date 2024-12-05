import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv/home/domain/use-case/tv-top-rated-use-case.dart';
import 'package:movie/features/tv/home/presentation/view-model/top-rated/states.dart';

class TvTopRatedCubit extends Cubit<TvTopRatedStates> {
  TvTopRatedCubit(this.tvTopRatedUseCase) : super(TvTopRatedInitialState());
  static TvTopRatedCubit get(context) => BlocProvider.of(context);
  final TvTopRatedUseCase tvTopRatedUseCase;
  bool isFetchingMore = false;

  Future<void> fetchTvTopRatedData({int page = 1}) async {
    if (page == 1) {
      emit(FetchTvTopRatedDataLoadingState());
    } else if (!isFetchingMore) {
      emit(FetchTvTopRatedDataPaginationLoadingState());
      isFetchingMore = true;
    // ignore: curly_braces_in_flow_control_structures
    }else if(isFetchingMore)return ;

    final result = await tvTopRatedUseCase.call(page);

    result.fold(
      (failure) {
        emit(FetchTvTopRatedDataFailureState(failure.toString()));
        isFetchingMore = false;
      },
      (data) {
        emit(FetchTvTopRatedDataSuccessState(data));
        isFetchingMore = false;
      },
    );
  }
}
