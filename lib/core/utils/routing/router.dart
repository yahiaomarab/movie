import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/routing/routes.dart';
import 'package:movie/features/auth/presentation/view-model/login/cubit.dart';
import 'package:movie/features/auth/presentation/view-model/otp/otp-cubit.dart';
import 'package:movie/features/auth/presentation/view-model/register/cubit.dart';
import 'package:movie/features/auth/presentation/views/login/login-view.dart';
import 'package:movie/features/auth/presentation/views/otp/otp-verification.dart';
import 'package:movie/features/auth/presentation/views/register/register-view.dart';
import 'package:movie/features/auth/presentation/views/register/successfully-register-page.dart';
import 'package:movie/features/home-details/data/repo/home-details-repo.dart';
import 'package:movie/features/home-details/domain/use-case/home-details-use-case.dart';
import 'package:movie/features/home-details/presentation/view-model/cubit.dart';
import 'package:movie/features/home-details/presentation/view/home-details-view.dart';
import 'package:movie/features/home/data/repos/home-repo.dart';
import 'package:movie/features/home/domain/use-case/recommended-use-case.dart';
import 'package:movie/features/home/domain/use-case/trending-use-case.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/home/presentation/view-model/trending/trending-cubit.dart';
import 'package:movie/features/home/presentation/views/home-view.dart';
import 'package:movie/features/home/presentation/views/widgets/list-recommended.dart';
import 'package:movie/features/home/presentation/views/widgets/trending-view.dart';
import 'package:movie/features/layout/presentation/view-model/layout-cubit.dart';
import 'package:movie/features/layout/presentation/view/layout-view.dart';
import 'package:movie/features/on-boarding/data/repos/on-boarding-repository.dart';
import 'package:movie/features/on-boarding/domain/use-case/fetch-trending-images-use-case.dart';
import 'package:movie/features/on-boarding/presentation/view-model/cubit.dart';
import 'package:movie/features/on-boarding/presentation/views/on-boarding-view.dart';
import 'package:movie/features/settings/presentation/view/profile-view.dart';
import 'package:movie/features/settings/view-model/cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingPath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OnBoardingCubit(
              FetchTrendingImagesUseCase(
                locator.get<OnBoardingRepoImplmentation>(),
              ),
            )..fetchOnBoarding(),
            child: const OnBoardingScreen(),
          ),
        );
        
      case Routes.loginPath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
        );

      case Routes.registerPath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: RegisterScreen(),
          ),
        );

      case Routes.otpPath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OtpCubit(),
            child: OtpPage(),
          ),
        );

      case Routes.homePath:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<TrendingCubit>(
                create: (context) => TrendingCubit(
                  TrendingUseCase(locator.get<HomeRepoImpl>()),
                )..fetchTrendingMovies(),
              ),
              BlocProvider<RecommendedCubit>(
                create: (context) => RecommendedCubit(
                  RecommendedUseCase(locator.get<HomeRepoImpl>()),
                )..fetchRecommendedMovies(),
              ),
            ],
            child: const HomePage(),
          ),
        );
        
      case Routes.trendingPath:
        return MaterialPageRoute(builder: (_) => TrendingView());

      case Routes.recommendedPath:
        return MaterialPageRoute(builder: (_) => RecommendedMoviesList());

      case Routes.successfullyRegisteredPath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: SuccessfullyRegisterPage(),
          ),
        );

      case Routes.layoutPath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LayoutCubit(),
            child: const LayoutScreen(),
          ),
        );

      case Routes.homeDetailsViewPath:
        if (argument == null || !(argument is int)) {
          return _errorRoute('Invalid argument for HomeDetailsView');
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeDetailsCubit(
              HomeDetailsUseCase(locator.get<HomeDetailsRepoImp>()),
            ),
            child: HomeDetails(id: argument),
          ),
        );

      case Routes.profilePath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit()..getUserData(),
            child: ProfileScreen(),
          ),
        );

      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  MaterialPageRoute _errorRoute(String errorMessage) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(errorMessage),
        ),
      ),
    );
  }
}
