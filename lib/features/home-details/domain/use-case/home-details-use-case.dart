import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-with-parametars.dart';
import 'package:movie/features/home-details/domain/repo/home-details-repo.dart';

class HomeDetailsUseCase extends UseCase {
  final HomeDetailsRepo homeDetailsRepo;
  HomeDetailsUseCase(this.homeDetailsRepo);
  @override
  Future<Either<Failure, dynamic>> call([param]) async {
    try {
      return await homeDetailsRepo.fetchMovieDetails(id: param);
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}
