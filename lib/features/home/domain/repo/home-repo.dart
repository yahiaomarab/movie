import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, TrendingEntity>> fetchTrendingMovie();
  Future<Either<Failure, List<RecommendedEntity>>> fetchRecommendedMovies({int page=1});
}
