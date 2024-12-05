import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/tv/home/domain/entity/top-rated/tv-top-rated-entity.dart';

abstract class TvTopRatedRepo {
  Future<Either<Failure, List<TvTopRatedEntity>>> fetchTvTopRatedData(
      {int page = 1});
}
