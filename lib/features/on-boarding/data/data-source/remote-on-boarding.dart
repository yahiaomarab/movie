

import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';

abstract class OnBoardingRemoteDataSource {
  Future<List<TrendingEntity>> fetchRemoteTrendingImages({int pageNumber = 1});
}

class OnBoardingRemoteDataSourceImpl extends OnBoardingRemoteDataSource {
  final ApiServices apiServices;

  OnBoardingRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<TrendingEntity>> fetchRemoteTrendingImages({int pageNumber = 1}) async {
    final endPoint = '${ApiConstance.baseUrl}${ApiConstance.trendingDayUrl}?api_key=${ApiConstance.apiKey}&page=$pageNumber';
    print('Fetching data from: $endPoint');
    var data = await apiServices.getData(endPoint: endPoint);
    List<TrendingEntity> posters = getTrendingList(data);
    saveData(posters);
    print('Posters are: $posters');
    return posters;
  }

  List<TrendingEntity> getTrendingList(Map<String, dynamic> data) {
    List<TrendingEntity> trendPosters = [];
    for (var trendingPoster in data['results']) {
      if (trendingPoster['poster_path'] != null) {
        final fullImageUrl = 'https://image.tmdb.org/t/p/w500${trendingPoster['poster_path']}';
        trendPosters.add(TrendingEntity(posterImage: fullImageUrl));
      }
    }
    return trendPosters;
  }
}
