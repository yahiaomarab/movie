import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';


abstract class OnBoardingRepo {
  Future<Either<Failure, List<TrendingEntity>>> fetchTrendingImages({int pageNumber=1});
}
