import 'package:go_router/go_router.dart';
import 'package:movie/features/auth/presentation/views/login/login-view.dart';
import 'package:movie/features/auth/presentation/views/otp/otp-verification.dart';
import 'package:movie/features/auth/presentation/views/register/register-view.dart';
import 'package:movie/features/auth/presentation/views/register/successfully-register-page.dart';
import 'package:movie/features/home/presentation/views/home-view.dart';
import 'package:movie/features/on-boarding/presentation/views/on-boarding-view.dart';
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
  static final router = GoRouter(routes: [
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
        builder: (context, state) =>  SuccessfullyRegisterPage()),
           GoRoute(
        path: homePath,
        builder: (context, state) => const HomePage()),
  ]);
}
