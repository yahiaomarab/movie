import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/on-boarding/domain/use-case/fetch-trending-images-use-case.dart';
import 'package:movie/features/on-boarding/presentation/view-model/states.dart';


class OnBoardingCubit extends Cubit<OnBoardingStates> {
  final FetchTrendingImagesUseCase fetchTrendingImagesUseCase;

  OnBoardingCubit(this.fetchTrendingImagesUseCase)
      : super(OnBoardingInitialState());

  void fetchOnBoarding({int pageNumber=1}) async {
    emit(FetchOnBoardingLoadingState());
    final result = await fetchTrendingImagesUseCase.call(pageNumber);
    result.fold(
      (failure) {
        emit(FetchOnBoardingFailureState(failure.message));
      },
      (data) {
        emit(FetchOnBoardingSuccessState(data));
      },
    );
  }
}
