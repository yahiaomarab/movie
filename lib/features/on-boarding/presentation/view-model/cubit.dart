import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/on-boarding/domain/use-case/fetch-trending-images-use-case.dart';
import 'package:movie/features/on-boarding/presentation/view-model/states.dart';


class OnBoardingCubit extends Cubit<OnBoardingStates> {
  final FetchTrendingImagesUseCase fetchTrendingImagesUseCase;

  OnBoardingCubit(this.fetchTrendingImagesUseCase)
      : super(OnBoardingInitialState());

  void fetchOnBoarding() async {
    emit(FetchOnBoardingLoadingState());
    final result = await fetchTrendingImagesUseCase();
    result.fold(
      (failure) {
        print('State Error: ${failure.message}');
        emit(FetchOnBoardingFailureState(failure.message));
      },
      (data) {
        emit(FetchOnBoardingSuccessState(data));
      },
    );
  }
}
