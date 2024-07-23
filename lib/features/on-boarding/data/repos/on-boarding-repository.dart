import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/on-boarding/data/data-source/local-on-boarding.dart';
import 'package:movie/features/on-boarding/data/data-source/remote-on-boarding.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';
import 'package:movie/features/on-boarding/domain/repository/on-boarding-repo.dart';


class OnBoardingRepoImplmentation extends OnBoardingRepo {
  final OnBoardingRemoteDataSource onBoardingRemoteDataSource;
  final OnBoardingLocalDataSource onBoardingLocalDataSource;
  OnBoardingRepoImplmentation(
      this.onBoardingLocalDataSource, this.onBoardingRemoteDataSource);
  @override
  Future<Either<Failure, List<TrendingEntity>>> fetchTrendingImages(
      {int pageNumber = 1}) async {
    try {
      var postersLocal = onBoardingLocalDataSource.fetchLocalTrendingImages(
          pageNumber: pageNumber);
      if (postersLocal.isNotEmpty) {
        return right(postersLocal);
      }
      List<TrendingEntity> posters = await onBoardingRemoteDataSource
          .fetchRemoteTrendingImages(pageNumber: pageNumber);
      return right(posters);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
