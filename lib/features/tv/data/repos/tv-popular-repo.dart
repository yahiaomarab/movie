import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/tv/data/data-source/local/tv-popular.dart';
import 'package:movie/features/tv/data/data-source/remote/tv-popular.dart';
import 'package:movie/features/tv/domain/entity/tv-entity.dart';
import 'package:movie/features/tv/domain/repo/tv-popular-repo.dart';

class TvPopularRepoImpl extends TvPopularRepo {
  final TvPopularRemoteDataSource tvPopularRemoteDataSource;
  final TvPopularLocalDataSource tvPopularLocalDataSource;
  TvPopularRepoImpl(
      this.tvPopularLocalDataSource, this.tvPopularRemoteDataSource);
  @override
  Future<Either<Failure, List<TvEntity>>> fetchPouplarTv({int page = 1}) async {
    try {
      List<TvEntity> localResponse =
          tvPopularLocalDataSource.fetchTvPopularLocalData(page: page);
      if (localResponse.isNotEmpty) {
        return right(localResponse);
      } else {
        List<TvEntity> remoteResponse =
            await tvPopularRemoteDataSource.fetchTvPopularData(page: page);
        return right(remoteResponse);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
