import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/search/domain/entity/search-entity.dart';

abstract class SearchRepo {
  Future<Either< Failure,List<SearchEntity>>> fetchSearchResults(
      {int page = 1,required String query});
}
