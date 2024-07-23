import 'package:go_router/go_router.dart';
import 'package:movie/features/auth/presentation/views/login-view.dart';
import 'package:movie/features/auth/presentation/views/register-view.dart';
import 'package:movie/features/on-boarding/presentation/views/on-boarding-view.dart';
import 'package:movie/features/splash/presentation/views/splash-view.dart';


abstract class AppRouter {
  static const onBoardingPath = '/onBoardingPath';
  static const loginPath= '/loginPath';
  static const registerPath= '/registerPath';
  static const homeDetailsViewPath = '/homeDetailsView';
  static const searchViewPath = '/searchView';
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
      builder: (context,state)=> LoginScreen(),
    ),
     GoRoute(
      path: registerPath,
      builder: (context,state)=> RegisterScreen(),
    ),
  ]);
}
