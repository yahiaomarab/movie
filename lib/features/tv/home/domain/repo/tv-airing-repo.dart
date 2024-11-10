import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';

import '../entity/airing/tv-airing-entity.dart';

abstract class TvAiringRepo {
  Future<Either<Failure, List<TvAiringEntity>>> fetchAiringTv();
}
