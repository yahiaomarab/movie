import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/movies/similar-movie/data/data-source/similar-movie-loacl-source.dart';
import 'package:movie/features/movies/similar-movie/data/data-source/similar-movie-remote-source.dart';
import 'package:movie/features/movies/similar-movie/domain/entity/similar-movie-entity.dart';
import 'package:movie/features/movies/similar-movie/domain/repo/similar-movie-repo.dart';

class SimilarMovieRepoImpl extends SimilarMovieRepo {
  final SimilarMovieLocalSource similarMovieLocalSource;
  final SimilarMovieRemoteSource similarMovieRemoteSource;
  SimilarMovieRepoImpl(
      this.similarMovieLocalSource, this.similarMovieRemoteSource);
  @override
  Future<Either<Failure, List<SimilarMovieEntity>>> fetchSimilarMovie(
      {int page = 1, required int id}) async {
    try {
      var similarsLocal = similarMovieLocalSource.fetchSimilarMovie(id: id);
      if (similarsLocal.isNotEmpty) {
        return right(similarsLocal);
      } else {
        List<SimilarMovieEntity> similarsRemote =
            await similarMovieRemoteSource.fetchSimilarMovie(id: id);
        return right(similarsRemote);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
