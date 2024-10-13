import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-list-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/movies/home/data/models/recommended-model.dart';
import 'package:movie/features/movies/home/data/models/trending-model.dart';
import 'package:movie/features/movies/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/movies/home/domain/entity/trending/trending-entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<TrendingEntity>> fetchTrendingData();
  Future<List<RecommendedEntity>> fetchRecommendedData({int page = 1});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSourceImpl(this.apiServices);

  Future<dynamic> fetchData(String endPoint) async {
    try {
      return await apiServices.getData(endPoint: endPoint);
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Future<List<RecommendedEntity>> fetchRecommendedData({int page = 1}) async {
    final endPoint = '${ApiConstance.baseUrl}${ApiConstance.upComingMoviesUrl}?api_key=${ApiConstance.apiKey}&page=$page';
    final data = await fetchData(endPoint);
    List<RecommendedEntity> recommended = getListOfData<RecommendedEntity>(
      data,
      'results',
      (json) {
 
        return RecommendedModel.fromJson(json) as RecommendedEntity;
              // ignore: dead_code
              throw Exception('Invalid JSON format for RecommendedModel');
      },
    );
    if (recommended.isNotEmpty) {
      saveData(recommended, KRecommendedBox);
    }
    return recommended;
  }

  @override
  Future<List<TrendingEntity>> fetchTrendingData() async {
    const endPoint =
        '${ApiConstance.baseUrl}${ApiConstance.popularMoviesUrl}?api_key=${ApiConstance.apiKey}';
    final data = await fetchData(endPoint);
    List<TrendingEntity> trends = getListOfData<TrendingEntity>(
      data,
      'results',
      (json) {
 
        return TrendingModel.fromJson(json) as TrendingEntity;
              // ignore: dead_code
              throw Exception('Invalid JSON format for TrendingModel');
      },
    );
    if (trends.isNotEmpty) {
      saveData(trends, KTrendingBox);
    }
    return trends;
  }
}
