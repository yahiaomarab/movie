import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-without-parametars.dart';
import 'package:movie/features/home/domain/repo/home-repo.dart';

class TrendingUseCase extends UseCase {
  final HomeRepo homeRepo;
  TrendingUseCase(this.homeRepo);
  @override
  Future<Either<Failure, dynamic>> call() async {
    try {
      return await homeRepo.fetchTrendingMovie();
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}
