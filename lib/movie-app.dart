import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/core/utils/routing/routes.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  
  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: HexColor('#121011'),
    ));

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.dark(),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: HexColor('#121011'),
            appBarTheme: AppBarTheme(backgroundColor: HexColor('#121011')),
          ),
          themeMode: ThemeMode.dark,
          initialRoute: Routes.splashPath,
          onGenerateRoute: appRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          checkerboardOffscreenLayers: true,
        );
      },
    );
  }
}