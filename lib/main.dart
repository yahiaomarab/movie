import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie/core/helper/cache-constants.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/funcitons/simple-bloc-observer.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/features/on-boarding/data/repos/on-boarding-repository.dart';
import 'package:movie/features/on-boarding/domain/entities/trending-entity.dart';
import 'package:movie/features/on-boarding/domain/use-case/fetch-trending-images-use-case.dart';
import 'package:movie/features/on-boarding/presentation/view-model/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TrendingEntityAdapter());
  setUpServiceLocator();
  await Hive.openBox<TrendingEntity>(kOnBoardingBox);
  Bloc.observer = SimpleBlocObserver();
  runApp(const MovieApp());
}

final getIt = GetIt.instance;

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
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
                  ..fetchOnBoarding())
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
