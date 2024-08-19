import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/core/network/api-service.dart';
import 'package:movie/features/home/data/data-source/home-local-data-source.dart';
import 'package:movie/features/home/data/data-source/home-remote-data-source.dart';
import 'package:movie/features/home/data/repos/home-repo.dart';
import 'package:movie/features/on-boarding/data/data-source/local-on-boarding.dart';
import 'package:movie/features/on-boarding/data/data-source/remote-on-boarding.dart';
import 'package:movie/features/on-boarding/data/repos/on-boarding-repository.dart';

var locator = GetIt.instance;
void setUpServiceLocator() {
  locator.registerSingleton<OnBoardingRepoImplmentation>(
      OnBoardingRepoImplmentation(OnBoardingLocalDataSourceImpl(),
          OnBoardingRemoteDataSourceImpl(ApiServices(dio: Dio()))));

  locator.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
      HomeLocalDataSourceImpl(),
      HomeRemoteDataSourceImpl(ApiServices(dio: Dio()))));
}
