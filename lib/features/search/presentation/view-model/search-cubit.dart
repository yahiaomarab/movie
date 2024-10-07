import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';
import 'package:movie/features/search/domain/use-case/search-use-case.dart';
import 'package:movie/features/search/presentation/view-model/search-states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(this.searchUseCase) : super(InitialSearchState());
  static SearchCubit get(context) => BlocProvider.of(context);
  final SearchUseCase searchUseCase;
  bool isSearch = false;
  List<SearchEntity> searchList = [];

  void onCheckSearch(val) {
    if (val == '') {
      isSearch = false;
    }
    emit(SearchStateEmpty());
  }

  fetchSearchData({int page = 1, required String query}) async {
        searchList.clear();
    if (page == 1) {
      emit(FetchSearchDataLoadingState());
    } else {
      emit(FetchSearchDataPaginationLoadingState());
    }

    final response = await searchUseCase.call(page, query);

    response.fold(
      (failure) {
        emit(FetchSearchDataFailureState(failure.toString()));
      },
      (data) {
        searchList.addAll(data);
        isSearch = true;
        emit(FetchSearchDataSuccessState(data));
      },
    );
  }
}
