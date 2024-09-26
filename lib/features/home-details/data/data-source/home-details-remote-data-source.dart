import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/features/home-details/data/models/movie-model.dart';

abstract class HomeDetailsRemoteDataSource {
  Future<MovieModel> fetchMovieDetails({int id = 1});
}

class HomeDetailsRemoteDataImpl extends HomeDetailsRemoteDataSource {
  final ApiServices apiServices;
  HomeDetailsRemoteDataImpl(this.apiServices);
  @override
  Future<MovieModel> fetchMovieDetails({int id = 1}) async {
    final data = await apiServices.getData(
        endPoint:
            '${ApiConstance.baseUrl}${ApiConstance.moviesUrl}/$id?api_key=${ApiConstance.apiKey}');
    try {
      MovieModel movie = MovieModel.fromJson(data);
      return movie;
    } catch (e) {
      throw Exception(
          'Failed to parse movie data'); 
    }
  }
}
