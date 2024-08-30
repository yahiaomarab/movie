import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/helper/hive-services.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/funcitons/simple-bloc-observer.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/features/auth/presentation/view-model/login/cubit.dart';
import 'package:movie/features/auth/presentation/view-model/otp/otp-cubit.dart';
import 'package:movie/features/auth/presentation/view-model/register/cubit.dart';
import 'package:movie/features/home/data/repos/home-repo.dart';
import 'package:movie/features/home/domain/use-case/recommended-use-case.dart';
import 'package:movie/features/home/domain/use-case/trending-use-case.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-cubit.dart';
import 'package:movie/features/on-boarding/data/repos/on-boarding-repository.dart';
import 'package:movie/features/on-boarding/domain/use-case/fetch-trending-images-use-case.dart';
import 'package:movie/features/on-boarding/presentation/view-model/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize Hive
  final hiveService = HiveService();
  await hiveService.initHive();

  setUpServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MovieApp());
}

final getIt = GetIt.instance;

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#121011'), // Set the status bar color
      systemNavigationBarColor: HexColor('#121011'),
    ));
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => OnBoardingCubit(FetchTrendingImagesUseCase(
                    locator.get<OnBoardingRepoImplmentation>()))
                  ..fetchOnBoarding()),
            BlocProvider(create: (context) => OtpCubit()),
            BlocProvider(create: (context) => RegisterCubit()),
            BlocProvider(create: (context) => LoginCubit()),
            BlocProvider(
              create: (context) => TrendingCubit(
                TrendingUseCase(locator.get<HomeRepoImpl>()),
              )..fetchTrendingMovies(),
            ),
            BlocProvider(
                create: (context) => RecommendedCubit(
                    RecommendedUseCase(locator.get<HomeRepoImpl>()))
                  ..fetchRecommendedMovies())
          ],
          child: MaterialApp.router(
            theme: ThemeData.dark(),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('#121011'),
                appBarTheme: AppBarTheme(backgroundColor: HexColor('#121011'))),
            themeMode: ThemeMode.dark,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
