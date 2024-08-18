import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/on-boarding/domain/entities/onboarding-entity.dart';


abstract class OnBoardingRepo {
  Future<Either<Failure, List<OnBoardingEntity>>> fetchTrendingImages({int pageNumber=1});
}
