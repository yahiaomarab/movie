import 'package:dio/dio.dart';
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
  Future<dynamic> fetchData(String endPoint) async {
    try {
      return await apiServices.getData(endPoint: endPoint);
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Future<List<TvAiringEntity>> fetchTvAiringData() async {
    const endPoint =
        '${ApiConstance.baseUrl}${ApiConstance.onAirTvSeriesUrl}?api_key=${ApiConstance.apiKey}';

    final data = await fetchData(endPoint);
    List<TvAiringEntity> tvAiringList = getListOfData<TvAiringEntity>(
      data,
      'results',
      (json) {
        return AiringTvModel.fromJson(json) as TvAiringEntity;
        // ignore: dead_code
        throw Exception('Invalid JSON format for TVAiringModel');
      },
    );
    if (tvAiringList.isNotEmpty) {
      saveData(tvAiringList, KTvAiringBox);
    }
    return tvAiringList;
  }
}
