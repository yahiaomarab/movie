import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-list-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/tv/home/data/models/top-rated-tv-model.dart';
import 'package:movie/features/tv/home/domain/entity/top-rated/tv-top-rated-entity.dart';


abstract class TvTopRatedRemoteDataSource {
  Future<List<TvTopRatedEntity>> fetchTvTopRatedData({int page = 1});
}

class TvTopRatedRemoteDataSourceImpl extends TvTopRatedRemoteDataSource {
  final ApiServices apiServices;
  TvTopRatedRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<TvTopRatedEntity>> fetchTvTopRatedData({int page = 1}) async {
    final response = await apiServices.getData(
      endPoint:
        '${ApiConstance.baseUrl}${ApiConstance.topRatedTvSeriesUrl}?api_key=${ApiConstance.apiKey}&page=$page');
    List<TvTopRatedEntity> tvTopRatedList = getListOfData(
        response, 'results', (json) => TopRatedTVModel.fromJson(json) as TvTopRatedEntity);
    if (tvTopRatedList.isNotEmpty) {
      saveData(tvTopRatedList, KTvTopRatedBox);
    }
    return tvTopRatedList;
  }
}
