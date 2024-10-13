import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-with-parametars.dart';
import 'package:movie/features/movies/home/domain/repo/home-repo.dart';

class RecommendedUseCase extends UseCase {
  final HomeRepo homeRepo;
  RecommendedUseCase(this.homeRepo);
  @override
  Future<Either<Failure, dynamic>> call([param]) async{
    try{
      return await homeRepo.fetchRecommendedMovies(page: param);
    }catch(error){
      return left(ServerFailure(error.toString()));
    }
  }

}