import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/tv/home/data/data-source/local/tv-top-rated.dart';
import 'package:movie/features/tv/home/data/data-source/remote/tv-top-rated.dart';
import 'package:movie/features/tv/home/domain/entity/top-rated/tv-top-rated-entity.dart';
import 'package:movie/features/tv/home/domain/repo/tv-top-rated-repo.dart';


class TvTopRatedRepoImpl extends TvTopRatedRepo {
  final TvTopRatedRemoteDataSource tvTopRatedRemoteDataSource;
  final TvTopRatedLocalDataSource tvTopRatedLocalDataSource;

  TvTopRatedRepoImpl(
    this.tvTopRatedLocalDataSource,
    this.tvTopRatedRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<TvTopRatedEntity>>> fetchTvTopRatedData({int page = 1}) async {
    try {
      List<TvTopRatedEntity> localResponse = 
          tvTopRatedLocalDataSource.fetchTvTopRatedLocalData(page: page);
      if (localResponse.isNotEmpty) {
        return right(localResponse);
      } else {
        List<TvTopRatedEntity> remoteResponse =
            await tvTopRatedRemoteDataSource.fetchTvTopRatedData(page: page);
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
