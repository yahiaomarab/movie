import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/tv/domain/entity/tv-entity.dart';

abstract class TvPopularRepo {
  Future<Either<Failure, List<TvEntity>>> fetchPouplarTv({int page=1});
}
