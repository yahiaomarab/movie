import 'package:hive/hive.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/features/movies/similar-movie/domain/entity/similar-movie-entity.dart';

abstract class SimilarMovieLocalSource {
  List<SimilarMovieEntity> fetchSimilarMovie({int page = 1, required int id});
}

class SimilarMovieLocalSourceImpl extends SimilarMovieLocalSource {
  @override
  List<SimilarMovieEntity> fetchSimilarMovie({int page = 1, required int id}) {
    int startIndex = (page - 1) * 10;
    int endIndex = page * 10;
    var box = Hive.box<SimilarMovieEntity>(KSimilarListBox);
    int length = box.values.length;
    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }
}
