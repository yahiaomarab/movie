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
    String url =
        '${ApiConstance.baseUrl}${ApiConstance.multisearchUrl}?api_key=${ApiConstance.apiKey}&query=$query';

    // Log the full API request URL
    print('API Request URL: $url');

    try {
      var result = await apiServices.getData(endPoint: url);
      print('API Response: $result'); // Log the response

      List<SearchEntity> searchList = getListOfData<SearchEntity>(
            result,
            'results',
            (json) {
              return SearchModel.fromJson(json) as SearchEntity;
            },
          ) ??
          [];

      return searchList;
    } catch (e) {
      print('Error occurred: $e'); // Log the error for debugging
      throw e; // Re-throw the error to be handled by the repository
    }
  }
}
