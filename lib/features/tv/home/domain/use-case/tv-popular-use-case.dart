import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-with-parametars.dart';
import 'package:movie/features/tv/home/domain/repo/tv-popular-repo.dart';

class TvPopularUseCase extends UseCase {
  final TvPopularRepo tvPopularRepo;
  TvPopularUseCase(this.tvPopularRepo);
  @override
  Future<Either<Failure, dynamic>> call([param]) async {
    return await tvPopularRepo.fetchPouplarTv(page: param);
  }
}
