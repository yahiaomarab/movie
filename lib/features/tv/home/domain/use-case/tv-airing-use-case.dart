import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-without-parametars.dart';
import 'package:movie/features/tv/home/domain/repo/tv-Airing-repo.dart';

class TvAiringUseCase extends UseCase {
  final TvAiringRepo tvAiringRepo;
  TvAiringUseCase(this.tvAiringRepo);
  @override
  Future<Either<Failure, dynamic>> call() async {
    return await tvAiringRepo.fetchAiringTv();
  }
}
