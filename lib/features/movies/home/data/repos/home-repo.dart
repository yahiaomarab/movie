import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/movies/home/data/data-source/home-local-data-source.dart';
import 'package:movie/features/movies/home/data/data-source/home-remote-data-source.dart';
import 'package:movie/features/movies/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/movies/home/domain/entity/trending/trending-entity.dart';
import 'package:movie/features/movies/home/domain/repo/home-repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  HomeRepoImpl(this.homeLocalDataSource, this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<RecommendedEntity>>> fetchRecommendedMovies(
      {int page = 1}) async {
    try {
      var recmmendedLocal =
          homeLocalDataSource.fetchRecommendedDataLocal(page: page);
      if (recmmendedLocal.isNotEmpty) {
        return right(recmmendedLocal);
      }
      List<RecommendedEntity> recmmended =
          await homeRemoteDataSource.fetchRecommendedData(page: page);
      return right(recmmended);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrendingEntity>>> fetchTrendingMovie() async {
    try {
      var trendsLocal = homeLocalDataSource.fetchTrendingDataLocal();
      if (trendsLocal.isNotEmpty) {
        return right(trendsLocal);
      }
      List<TrendingEntity> trends =
          await homeRemoteDataSource.fetchTrendingData();
      return right(trends);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
