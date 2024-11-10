import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv/home/domain/use-case/tv-airing-use-case.dart';
import 'package:movie/features/tv/home/presentation/view-model/airing/states.dart';


class TvAiringCubit extends Cubit<TvAiringStates> {
  TvAiringCubit(this.tvAiringUseCase) : super(InitialTvAiringStates());

  static TvAiringCubit get(context) => BlocProvider.of(context);
  final TvAiringUseCase tvAiringUseCase;
  bool isFetchingMore = false;

  Future<void> fetchTvAiringData() async {
    
      emit(FetchTvAiringDataLoadingState());
   

    final result = await tvAiringUseCase.call();

    result.fold(
      (failure) {
        emit(FetchTvAiringDataFailureState(failure.toString()));
        isFetchingMore = false;
      },
      (data) {
        emit(FetchTvAiringDataSuccessState(data));
        isFetchingMore = false;
      },
    );
  }
}
