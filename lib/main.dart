import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/helper/cache-helper.dart';
import 'package:movie/core/helper/hive-services.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/funcitons/simple-bloc-observer.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/movie-app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize CacheHelper
  await CacheHelper.init();

  // Initialize Hive
  final hiveService = HiveService();
  await hiveService.initHive();

  // Setup service locator
  setUpServiceLocator();

  // Set up Bloc observer
  Bloc.observer = SimpleBlocObserver();


  // Run the app
  runApp( MovieApp(
    appRouter:AppRouter()
  ));
}




