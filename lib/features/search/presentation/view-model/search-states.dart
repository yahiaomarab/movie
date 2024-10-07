import 'package:movie/features/search/domain/entity/search-entity.dart';

abstract class SearchStates{}
class InitialSearchState extends SearchStates{}
class FetchSearchDataLoadingState extends SearchStates{}
class FetchSearchDataFailureState extends SearchStates{
  final String failure;
  FetchSearchDataFailureState(this.failure);
}
class FetchSearchDataPaginationLoadingState extends SearchStates{}
class FetchSearchDataSuccessState extends SearchStates{
  final List<SearchEntity>searchList;
  FetchSearchDataSuccessState(this.searchList);
}
class SearchStateEmpty extends  SearchStates{}