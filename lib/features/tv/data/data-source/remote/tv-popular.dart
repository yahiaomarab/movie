import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-list-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/tv/data/models/popular-tv-model.dart';
import 'package:movie/features/tv/domain/entity/tv-entity.dart';

abstract class TvPopularRemoteDataSource {
  Future<List<TvEntity>> fetchTvPopularData({int page = 1});
}

class TvPopularRemoteDataSourceImpl extends TvPopularRemoteDataSource {
  final ApiServices apiServices;
  TvPopularRemoteDataSourceImpl(this.apiServices);
  @override
  Future<List<TvEntity>> fetchTvPopularData({int page = 1}) async {
    final response = await apiServices.getData(
        endPoint:
            '${ApiConstance.baseUrl}${ApiConstance.popularTvSeriesUrl}?api_key=${ApiConstance.apiKey}&page=$page');
    List<TvEntity> tvPopularList = getListOfData(
        response, 'results', (json) => PopularTVModel.fromJson(json));
    if (tvPopularList.isNotEmpty) {
      saveData(tvPopularList, KTvBox);
    }
    return tvPopularList;
  }
}
