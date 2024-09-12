import 'package:go_router/go_router.dart';
import 'package:movie/core/helper/cache-helper.dart';
import 'package:movie/features/auth/presentation/views/login/login-view.dart';
import 'package:movie/features/auth/presentation/views/otp/otp-verification.dart';
import 'package:movie/features/auth/presentation/views/register/register-view.dart';
import 'package:movie/features/auth/presentation/views/register/successfully-register-page.dart';
import 'package:movie/features/home/presentation/views/home-view.dart';
import 'package:movie/features/layout/presentation/view/layout-view.dart';
import 'package:movie/features/on-boarding/presentation/views/on-boarding-view.dart';
import 'package:movie/features/settings/presentation/view/profile-view.dart';
import 'package:movie/features/splash/presentation/views/splash-view.dart';

abstract class AppRouter {
  static const onBoardingPath = '/onBoardingPath';
  static const loginPath = '/loginPath';
  static const registerPath = '/registerPath';
  static const homeDetailsViewPath = '/homeDetailsView';
  static const searchViewPath = '/searchView';
  static const homePath = '/homePath';
  static const otpPath = '/otpPath';
  static const successfullyRegisteredPath = '/successfullyRegisteredPath';
  static const layoutPath = '/layoutPath';
  static const profilePath = '/settings/profilePath';
  static final router = GoRouter(
    redirect: (context, state) async {
      bool isOnboardingCompleted = await CacheHelper.getBoardingMode() ?? false;
      bool isLoggedIn = await CacheHelper.getUid() ?? false;

      if (state.uri.toString() == profilePath) {
        // Allow navigation to profilePath without redirection
        return null;
      }

      if (isLoggedIn) {
        return layoutPath;
      } else if (isOnboardingCompleted) {
        return loginPath;
      } else {
        return onBoardingPath;
      }
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onBoardingPath,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: loginPath,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: registerPath,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: otpPath,
        builder: (context, state) => OtpPage(),
      ),
      GoRoute(
        path: successfullyRegisteredPath,
        builder: (context, state) => SuccessfullyRegisterPage(),
      ),
      GoRoute(
        path: homePath,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: layoutPath,
        builder: (context, state) => const LayoutScreen(),
      ),
      GoRoute(
        path: profilePath,
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
}
