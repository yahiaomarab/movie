import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-object-to-dart.dart';
import 'package:movie/features/home-details/data/models/movie-model.dart';

abstract class HomeDetailsRemoteDataSource {
  Future<MovieModel> fetchMovieDetails({int id = 1});
}

class HomeDetailsRemoteImpl extends HomeDetailsRemoteDataSource {
  final ApiServices apiServices;
  HomeDetailsRemoteImpl(this.apiServices);
  @override
  Future<MovieModel> fetchMovieDetails({int id = 1}) async {
    final data = await apiServices.getData(
        endPoint: '${ApiConstance.moviesUrl}/$id?${ApiConstance.apiKey}');
    MovieModel movie = getObjectFromJson<MovieModel>(
      data,
      'results',
      (json) => MovieModel.fromJson(json),
    );
    return movie;
  }
}
