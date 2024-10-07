import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-list-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/search/data/model/search-model.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';

abstract class SearchRemoteData {
  Future<List<SearchEntity>> fetchSearchData({
    int page = 1,
    required String query,
  });
}

class SearchRemoteDataImpl extends SearchRemoteData {
  final ApiServices apiServices;
  SearchRemoteDataImpl(this.apiServices);

  @override
  Future<List<SearchEntity>> fetchSearchData(
      {int page = 1, required String query}) async {
    var result = await apiServices.getData(
      endPoint:
          '${ApiConstance.baseUrl}${ApiConstance.multisearchUrl}?api_key=${ApiConstance.apiKey}&query=$query',
    );
    List<SearchEntity> searchList = getListOfData<SearchEntity>(
      result,
      'results',
      (json) {
        return SearchModel.fromJson(json) as SearchEntity;
      },
    );
    if (searchList.isNotEmpty) {
      saveData(searchList, KSearchListBox);
    }
    return searchList;
  }
}
