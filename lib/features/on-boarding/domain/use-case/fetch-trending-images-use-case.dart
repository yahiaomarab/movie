import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/on-boarding/domain/repository/on-boarding-repo.dart';

import '../../../../core/use-cases/use-case-with-parametars.dart';


class FetchTrendingImagesUseCase extends UseCase {
  final OnBoardingRepo onBoardingRepo;
  FetchTrendingImagesUseCase(this.onBoardingRepo);
  @override
  Future<Either<Failure, dynamic>> call([param = 1]) async {
    try {
      return await onBoardingRepo.fetchTrendingImages(pageNumber: param);
    } catch (error) {
      return Left(ServerFailure( error.toString()));
    }
  }
}
