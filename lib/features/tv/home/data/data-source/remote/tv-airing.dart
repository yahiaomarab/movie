import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-list-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/tv/home/data/models/airing-tv-model.dart';
import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';

abstract class TvAiringRemoteDataSource {
  Future<List<TvAiringEntity>> fetchTvAiringData();
}

class TvAiringRemoteDataSourceImpl extends TvAiringRemoteDataSource {
  final ApiServices apiServices;
  TvAiringRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<TvAiringEntity>> fetchTvAiringData() async {
    final response = await apiServices.getData(
      endPoint:
        '${ApiConstance.baseUrl}${ApiConstance.onAirTvSeriesUrl}?api_key=${ApiConstance.apiKey}'
        );
    List<TvAiringEntity> tvAiringList = getListOfData(
        response, 'results', (json) => AiringTvModel.fromJson(json) as TvAiringEntity);
    if (tvAiringList.isNotEmpty) {
      saveData(tvAiringList, KTvAiringBox);
    }
    return tvAiringList;
  }
}
