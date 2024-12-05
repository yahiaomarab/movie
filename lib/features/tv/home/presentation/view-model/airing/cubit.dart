import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';
import 'package:movie/features/tv/home/domain/use-case/tv-airing-use-case.dart';
import 'package:movie/features/tv/home/presentation/view-model/airing/states.dart';


class TvAiringCubit extends Cubit<TvAiringStates> {
  TvAiringCubit(this.tvAiringUseCase) : super(InitialTvAiringStates());

  static TvAiringCubit get(context) => BlocProvider.of(context);
  final TvAiringUseCase tvAiringUseCase;
  List<TvAiringEntity> _cachedAiring = [];
void fetchTvAiringData() async {
  if(_cachedAiring.isNotEmpty){
    emit(FetchTvAiringDataSuccessState(_cachedAiring));
    return;
  }
  emit(FetchTvAiringDataLoadingState());
  final result = await tvAiringUseCase.call();
  result.fold(
  (failure) {
    emit(FetchTvAiringDataFailureState(failure.message));
  },
  (data) {
    emit(FetchTvAiringDataSuccessState(data));
  },
);
}

}
