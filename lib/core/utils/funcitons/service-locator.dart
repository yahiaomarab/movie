import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/features/movies/home-details/data/data-source/home-details-remote-data-source.dart';
import 'package:movie/features/movies/home-details/data/repo/home-details-repo.dart';
import 'package:movie/features/movies/home/data/data-source/home-local-data-source.dart';
import 'package:movie/features/movies/home/data/data-source/home-remote-data-source.dart';
import 'package:movie/features/movies/home/data/repos/home-repo.dart';
import 'package:movie/features/movies/similar-movie/data/data-source/similar-movie-loacl-source.dart';
import 'package:movie/features/movies/similar-movie/data/data-source/similar-movie-remote-source.dart';
import 'package:movie/features/movies/similar-movie/data/repo/similar-movie-repo-impl.dart';
import 'package:movie/features/on-boarding/data/data-source/local-on-boarding.dart';
import 'package:movie/features/on-boarding/data/data-source/remote-on-boarding.dart';
import 'package:movie/features/on-boarding/data/repos/on-boarding-repository.dart';
import 'package:movie/features/search/data/data-source/search-remote-data.dart';
import 'package:movie/features/search/data/repo/search-repo-impl.dart';
import 'package:movie/features/tv/home/data/data-source/local/tv-popular.dart';
import 'package:movie/features/tv/home/data/data-source/remote/tv-airing.dart';
import 'package:movie/features/tv/home/data/data-source/remote/tv-popular.dart';
import 'package:movie/features/tv/home/data/repos/tv-airing-repo.dart';
import 'package:movie/features/tv/home/data/repos/tv-popular-repo.dart';

var locator = GetIt.instance;
void setUpServiceLocator() {
  locator.registerSingleton<OnBoardingRepoImplmentation>(
      OnBoardingRepoImplmentation(OnBoardingLocalDataSourceImpl(),
          OnBoardingRemoteDataSourceImpl(ApiServices(dio: Dio()))));

  locator.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
      HomeLocalDataSourceImpl(),
      HomeRemoteDataSourceImpl(ApiServices(dio: Dio()))));

  locator.registerSingleton<HomeDetailsRepoImp>(
      HomeDetailsRepoImp(HomeDetailsRemoteDataImpl(ApiServices(dio: Dio()))));
  locator.registerSingleton<SearchRepoImpl>(
      SearchRepoImpl(SearchRemoteDataImpl(ApiServices(dio: Dio()))));

  locator.registerSingleton<SimilarMovieRepoImpl>(
    SimilarMovieRepoImpl(
      SimilarMovieLocalSourceImpl(),
      SimilarMovieRemoteSourceImpl(
        ApiServices(
          dio: Dio(),
        ),
      ),
    ),
  );

    locator.registerSingleton<TvPopularRepoImpl>(
    TvPopularRepoImpl(
      TvPopularLocalDataSourceImp(),
      TvPopularRemoteDataSourceImpl(
        ApiServices(
          dio: Dio(),
        ),
      ),
    ),
  );

      locator.registerSingleton<TvAiringRepoImpl>(
    TvAiringRepoImpl(
      TvAiringRemoteDataSourceImpl(
        ApiServices(
          dio: Dio(),
        ),
      ),
    ),
  );
}
