import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/movies/similar-movie/domain/entity/similar-movie-entity.dart';

abstract class SimilarMovieRepo {
  Future<Either<Failure, List<SimilarMovieEntity>>> fetchSimilarMovie(
      {int page = 1,required int id});
}
