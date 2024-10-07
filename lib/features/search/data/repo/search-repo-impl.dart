import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/search/data/data-source/search-local-data.dart';
import 'package:movie/features/search/data/data-source/search-remote-data.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';
import 'package:movie/features/search/domain/repo/search-repo.dart';

class SearchRepoImpl extends SearchRepo {
  final SearchRemoteData searchRemoteData;
  final SearchLocalData searchLocalData;

  SearchRepoImpl(this.searchLocalData, this.searchRemoteData);

  @override
  Future<Either< Failure,List<SearchEntity>>> fetchSearchResults({
    int page = 1,
    required String query,
  }) async {
    try {
      // Fetch local data
      var searchLocal =
          searchLocalData.fetchSearchLocalData(page: page, query: query);
      if (searchLocal.isNotEmpty) {
        return right(searchLocal); // Return success as the left side
      }

      // Fetch remote data if local data is empty
      List<SearchEntity> searchRemote =
          await searchRemoteData.fetchSearchData(page: page, query: query);
      return right(searchRemote); // Return success as the left side
    } catch (e) {
      // Handle DioException
      if (e is DioException) {
        return left(
            ServerFailure.fromDiorError(e)); // Return failure on the right
      }

      // Return general failure
      return left(ServerFailure(e.toString())); // Return failure on the right
    }
  }
}
