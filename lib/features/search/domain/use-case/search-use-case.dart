import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/core/use-cases/use-case-with-parametars.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';
import 'package:movie/features/search/domain/repo/search-repo.dart';

class SearchUseCase extends UseCase {
  final SearchRepo searchRepo;
  SearchUseCase(this.searchRepo);

  @override
  Future<Either<Failure,List<SearchEntity>>> call([param]) async {
    try {
      return searchRepo.fetchSearchResults(query: param);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}

