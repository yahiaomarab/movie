import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/home/data/models/recommended-model.dart';
import 'package:movie/features/home/data/models/trending-model.dart';
import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<TrendingEntity>> fetchTrendingData();
  Future<List<RecommendedEntity>> fetchRecommendedData({int page=1});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<RecommendedEntity>> fetchRecommendedData({int page = 1}) async {
    final endPoint =
        '${ApiConstance.baseUrl}${ApiConstance.upComingMoviesUrl}?api_key=${ApiConstance.apiKey}&page=$page';
    final data = await apiServices.getData(endPoint: endPoint);
    List<RecommendedEntity> recommended = getListOfData<RecommendedEntity>(
      data,
      'results',
      (json) => RecommendedModel.fromJson(json) as RecommendedEntity,
    );
    saveData(recommended, KTrendingBox);
    return recommended;
  }

  @override
  Future<List<TrendingEntity>> fetchTrendingData() async {
    const endPoint =
        '${ApiConstance.baseUrl}${ApiConstance.popularMoviesUrl}?api_key=${ApiConstance.apiKey}';
    final data = await apiServices.getData(endPoint: endPoint);
    List<TrendingEntity> trends = getListOfData<TrendingEntity>(
      data,
      'results',
      (json) => TrendingModel.fromJson(json) as TrendingEntity,
    );
    saveData(trends, KTrendingBox);
    return trends;
  }
}

