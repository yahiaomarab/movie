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
import 'package:movie/features/movies/home-details/data/repo/home-details-repo.dart';
import 'package:movie/features/movies/home-details/domain/use-case/home-details-use-case.dart';
import 'package:movie/features/movies/home-details/presentation/view-model/cubit.dart';
import 'package:movie/features/movies/home-details/presentation/view/home-details-view.dart';
import 'package:movie/features/movies/home/data/repos/home-repo.dart';
import 'package:movie/features/movies/home/domain/use-case/recommended-use-case.dart';
import 'package:movie/features/movies/home/domain/use-case/trending-use-case.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/movies/home/presentation/view-model/trending/trending-cubit.dart';
import 'package:movie/features/movies/home/presentation/views/home-view.dart';
import 'package:movie/features/movies/home/presentation/views/widgets/list-recommended.dart';
import 'package:movie/features/movies/home/presentation/views/widgets/trending-view.dart';
import 'package:movie/features/layout/presentation/view-model/layout-cubit.dart';
import 'package:movie/features/layout/presentation/view/layout-view.dart';
import 'package:movie/features/movies/see-all/presentation/view/see-all-page.dart';
import 'package:movie/features/movies/similar-movie/data/repo/similar-movie-repo-impl.dart';
import 'package:movie/features/movies/similar-movie/domain/use-case/similar-movie-use-case.dart';
import 'package:movie/features/movies/similar-movie/presentation/view-model/cubit.dart';
import 'package:movie/features/movies/similar-movie/presentation/view/similar-movie-view.dart';
import 'package:movie/features/on-boarding/data/repos/on-boarding-repository.dart';
import 'package:movie/features/on-boarding/domain/use-case/fetch-trending-images-use-case.dart';
import 'package:movie/features/on-boarding/presentation/view-model/cubit.dart';
import 'package:movie/features/on-boarding/presentation/views/on-boarding-view.dart';
import 'package:movie/features/profile/presentation/view/profile-view.dart';
import 'package:movie/features/profile/view-model/cubit.dart';
import 'package:movie/features/search/data/repo/search-repo-impl.dart';
import 'package:movie/features/search/domain/use-case/search-use-case.dart';
import 'package:movie/features/search/presentation/search-view.dart';
import 'package:movie/features/search/presentation/view-model/search-cubit.dart';
import 'package:movie/features/splash/presentation/views/splash-view.dart';
import 'package:movie/features/tv/home/data/repos/tv-airing-repo.dart';
import 'package:movie/features/tv/home/data/repos/tv-popular-repo.dart';
import 'package:movie/features/tv/home/domain/use-case/tv-airing-use-case.dart';
import 'package:movie/features/tv/home/domain/use-case/tv-popular-use-case.dart';
import 'package:movie/features/tv/home/presentation/view-model/airing/cubit.dart';
import 'package:movie/features/tv/home/presentation/view-model/popular/cubit.dart';
import 'package:movie/features/tv/home/presentation/view/tv-view.dart';
import 'package:movie/features/tv/home/presentation/view/widgets/tv-popular.dart';
import 'package:movie/features/tv/home/presentation/view/widgets/tv-airing.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case Routes.splashPath:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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
            create: (context) => OtpCubit(),
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
      case Routes.seriesPath:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => TvPopularCubit(
                      TvPopularUseCase(locator.get<TvPopularRepoImpl>()),
                    )..fetchTvPopularData(),
                  ),
                   BlocProvider(
                    create: (context) => TvAiringCubit(
                      TvAiringUseCase(locator.get<TvAiringRepoImpl>()),
                    )..fetchTvAiringData(),
                  ),
                ], child: const SeriesPage()));
      case Routes.tvPopularPath:
        return MaterialPageRoute(builder: (_) => const TVPopular());
      case Routes.tvAiringPath:
        return MaterialPageRoute(builder: (_) => const TVAiring());
      case Routes.searchViewPath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                SearchCubit(SearchUseCase(locator.get<SearchRepoImpl>())),
            child: SearchScreen(),
          ),
        );
      case Routes.trendingPath:
        return MaterialPageRoute(builder: (_) => const TrendingView());

      case Routes.recommendedPath:
        return MaterialPageRoute(builder: (_) => const RecommendedMoviesList());
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
      case Routes.similarPath:
        if (argument == null || argument is! int) {
          return _errorRoute('Invalid argument for HomeDetailsView');
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SimilarMovieCubit(
              SimilarMovieUseCase(
                locator.get<SimilarMovieRepoImpl>(),
              ),
            ),
            child: SimilarMovieView(id: argument),
          ),
        );
      case Routes.homeDetailsViewPath:
        if (argument == null || argument is! int) {
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
      case Routes.seeAllPath:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => RecommendedCubit(
                      RecommendedUseCase(locator.get<HomeRepoImpl>()),
                    )..fetchRecommendedMovies(),
                child: SeeAllPage()));
      case Routes.profilePath:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit()..getUserData(),
            child: ProfileScreen(showBackButton: true),
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
