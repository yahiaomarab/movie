import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/home-details/data/data-source/home-details-remote-data-source.dart';
import 'package:movie/features/home-details/data/models/movie-model.dart';
import 'package:movie/features/home-details/domain/repo/home-details-repo.dart';

class HomeDetailsRepoImp extends HomeDetailsRepo {
  final HomeDetailsRemoteDataSource homeDetailsRemoteDataSource;
  HomeDetailsRepoImp(this.homeDetailsRemoteDataSource);
  @override
  Future<Either<Failure, MovieModel>> fetchMovieDetails(
      {required int id}) async {
    try {
      MovieModel movie =
          await homeDetailsRemoteDataSource.fetchMovieDetails(id: id);
      return right(movie);
    } catch (e) {
      print('Error: $e'); // Log the error for debugging.
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
