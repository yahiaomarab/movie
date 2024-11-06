import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-list-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/tv/home/data/models/popular-tv-model.dart';
import 'package:movie/features/tv/home/domain/entity/tv-popular-entity.dart';

abstract class TvPopularRemoteDataSource {
  Future<List<TvPopularEntity>> fetchTvPopularData({int page = 1});
}

class TvPopularRemoteDataSourceImpl extends TvPopularRemoteDataSource {
  final ApiServices apiServices;
  TvPopularRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<TvPopularEntity>> fetchTvPopularData({int page = 1}) async {
    final response = await apiServices.getData(
      endPoint:
        '${ApiConstance.baseUrl}${ApiConstance.popularTvSeriesUrl}?api_key=${ApiConstance.apiKey}&page=$page');
    List<TvPopularEntity> tvPopularList = getListOfData(
        response, 'results', (json) => PopularTVModel.fromJson(json) as TvPopularEntity);
    if (tvPopularList.isNotEmpty) {
      saveData(tvPopularList, KTvBox);
    }
    return tvPopularList;
  }
}
