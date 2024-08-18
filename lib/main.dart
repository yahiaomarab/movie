import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/funcitons/simple-bloc-observer.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/features/auth/presentation/view-model/login/cubit.dart';
import 'package:movie/features/auth/presentation/view-model/otp/otp-cubit.dart';
import 'package:movie/features/auth/presentation/view-model/register/cubit.dart';
import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/home/domain/entity/trending/trending-entity.dart';
import 'package:movie/features/on-boarding/data/repos/on-boarding-repository.dart';
import 'package:movie/features/on-boarding/domain/entities/onboarding-entity.dart';
import 'package:movie/features/on-boarding/domain/use-case/fetch-trending-images-use-case.dart';
import 'package:movie/features/on-boarding/presentation/view-model/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure this is correctly initialized
  await Hive.initFlutter();
  Hive.registerAdapter(OnBoardingEntityAdapter());
  Hive.registerAdapter(TrendingEntityAdapter());
  Hive.registerAdapter(RecommendedEntityAdapter());
  await Hive.openBox<OnBoardingEntity>(kOnBoardingBox);
  await Hive.openBox<TrendingEntity>(KTrendingBox);
  await Hive.openBox<RecommendedEntity>(KRecommendedBox);
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
            BlocProvider(create: (context) => LoginCubit())
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
