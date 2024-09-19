import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home-details/domain/use-case/home-details-use-case.dart';
import 'package:movie/features/home-details/presentation/view-model/states.dart';

class HomeDetailsCubit extends Cubit<HomeDetailsStates> {
  HomeDetailsCubit(this.homeDetailsUseCase) : super(InitialHomeDetailsState());
  static HomeDetailsCubit get(context) => BlocProvider.of(context);
  final HomeDetailsUseCase homeDetailsUseCase;

  Future<void> fetchMovieDetails(id) async {
    emit(FetchHomeDetailsLoadingState());
    final result = await homeDetailsUseCase.call(id);
    result.fold((failure) {
      emit(FetchHomeDetailsFailureState(failure.toString()));
    }, (data) {
      emit(FetchHomeDetailsSuccessState(data));
    });
  }
}
