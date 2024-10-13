import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/network/api-constants.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/core/utils/funcitons/convert-data-list-to-dart.dart';
import 'package:movie/core/utils/funcitons/save-box.dart';
import 'package:movie/features/movies/similar-movie/data/model/similar-movie-model.dart';
import 'package:movie/features/movies/similar-movie/domain/entity/similar-movie-entity.dart';

abstract class SimilarMovieRemoteSource {
  Future<List<SimilarMovieEntity>> fetchSimilarMovie(
      {int page = 1, required int id});
}

class SimilarMovieRemoteSourceImpl extends SimilarMovieRemoteSource {
  final ApiServices apiServices;
  SimilarMovieRemoteSourceImpl(this.apiServices);
  @override
  Future<List<SimilarMovieEntity>> fetchSimilarMovie(
      {int page = 1, required int id}) async {
    final endPoint =
        '${ApiConstance.baseUrl}${ApiConstance.moviesUrl}/$id${ApiConstance.similarMovie}?api_key=${ApiConstance.apiKey}';
    final response = await apiServices.getData(endPoint: endPoint);
    List<SimilarMovieEntity> similars = getListOfData(response, 'results',
        (json) => SimilarMovieModel.fromJson(json) as SimilarMovieEntity);
    if (similars.isNotEmpty) {
      saveData(similars, KSimilarListBox);
    }
    return similars;
  }
}
