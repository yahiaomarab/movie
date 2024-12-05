import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-with-parametars.dart';
import 'package:movie/features/tv/home/domain/repo/tv-top-rated-repo.dart';

class TvTopRatedUseCase extends UseCase{
  TvTopRatedRepo topRatedRepo;
  TvTopRatedUseCase(this.topRatedRepo);
  @override
  Future<Either<Failure, dynamic>> call([param]) async{
   return await topRatedRepo.fetchTvTopRatedData(page: param);
  }

}