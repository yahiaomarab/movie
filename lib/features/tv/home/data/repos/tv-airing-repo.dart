import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie/core/network/failure.dart';
import 'package:movie/features/tv/home/data/data-source/remote/tv-airing.dart';
import 'package:movie/features/tv/home/domain/entity/airing/tv-airing-entity.dart';
import 'package:movie/features/tv/home/domain/repo/tv-Airing-repo.dart';


class TvAiringRepoImpl extends TvAiringRepo {
  final TvAiringRemoteDataSource tvAiringRemoteDataSource;

  TvAiringRepoImpl(
    this.tvAiringRemoteDataSource,
  );
  
  @override
  Future<Either<Failure, List<TvAiringEntity>>> fetchAiringTv() async{
     try {     
        List<TvAiringEntity> remoteResponse =
            await tvAiringRemoteDataSource.fetchTvAiringData();
        return right(remoteResponse);
      
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }



}
