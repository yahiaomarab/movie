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

  void onCheckSearch(String val) {
    if (val.isEmpty) {
      isSearch = false;
      searchList.clear();  
      emit(SearchStateEmpty()); // Emit a state that shows the background
    } else {
      // Optionally, you can also start a new search here
      fetchSearchData(query: val); // This will fetch the results based on the new input
    }
  }

  fetchSearchData({ required String query}) async {
      searchList.clear();
      emit(FetchSearchDataLoadingState());
    

    final response = await searchUseCase.call( query);

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
