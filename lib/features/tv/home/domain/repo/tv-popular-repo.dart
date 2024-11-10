import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';

import '../entity/popular/tv-popular-entity.dart';

abstract class TvPopularRepo {
  Future<Either<Failure, List<TvPopularEntity>>> fetchPouplarTv({int page=1});
}
