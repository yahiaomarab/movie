

import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/on-boarding/domain/entities/onboarding-entity.dart';

abstract class OnBoardingRemoteDataSource {
  Future<List<OnBoardingEntity>> fetchRemoteTrendingImages({int pageNumber = 1});
}

class OnBoardingRemoteDataSourceImpl extends OnBoardingRemoteDataSource {
  final ApiServices apiServices;

  OnBoardingRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<OnBoardingEntity>> fetchRemoteTrendingImages({int pageNumber = 1}) async {
    final endPoint = '${ApiConstance.baseUrl}${ApiConstance.trendingDayUrl}?api_key=${ApiConstance.apiKey}&page=$pageNumber';
    var data = await apiServices.getData(endPoint: endPoint);
    List<OnBoardingEntity> posters = getTrendingList(data);
    saveData(posters,kOnBoardingBox);
    return posters;
  }

  List<OnBoardingEntity> getTrendingList(Map<String, dynamic> data) {
    List<OnBoardingEntity> trendPosters = [];
    for (var trendingPoster in data['results']) {
      if (trendingPoster['poster_path'] != null) {
        final fullImageUrl = 'https://image.tmdb.org/t/p/w500${trendingPoster['poster_path']}';
        trendPosters.add(OnBoardingEntity(posterImage: fullImageUrl));
      }
    }
    return trendPosters;
  }
}
