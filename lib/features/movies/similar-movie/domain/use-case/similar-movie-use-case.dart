import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-with-parametars.dart';
import 'package:movie/features/movies/similar-movie/domain/repo/similar-movie-repo.dart';

class SimilarMovieUseCase extends UseCaseWithAntherParam{
  final SimilarMovieRepo similarMovieRepo;
  SimilarMovieUseCase(this.similarMovieRepo);
  @override
  Future<Either<Failure, dynamic>> call([param,antherParam]) async{
    return await similarMovieRepo.fetchSimilarMovie(page: param,id: antherParam);
  }
  
}