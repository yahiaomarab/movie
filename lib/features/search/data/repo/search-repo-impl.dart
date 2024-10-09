import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/search/data/data-source/search-remote-data.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';
import 'package:movie/features/search/domain/repo/search-repo.dart';

class SearchRepoImpl extends SearchRepo {
  final SearchRemoteData searchRemoteData;

  SearchRepoImpl(this.searchRemoteData);

  @override
  Future<Either<Failure, List<SearchEntity>>> fetchSearchResults({int page = 1, required String query}) async {
    try {
      List<SearchEntity> searchRemote = await searchRemoteData.fetchSearchData(page: page, query: query);
      return right(searchRemote);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      
      return left(ServerFailure(e.toString()));
    }
  }
}
