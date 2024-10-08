import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/helper/cache-helper.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    initRotatingAndScalingAnimation();
    _navigateBasedOnState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _navigateBasedOnState() async {
    // Retrieve the cached values
    bool isOnboardingComplete = await CacheHelper.getBoardingMode() ?? false;
    bool isUserLoggedIn = await CacheHelper.getUid() != null;

    // Navigate based on the state of onboarding and login
    if (isOnboardingComplete && isUserLoggedIn) {
      // Navigate to main layout if both onboarding and login are complete
      Navigator.pushReplacementNamed(context, Routes.layoutPath);
    } else if (!isOnboardingComplete) {
      // Navigate to onboarding if it's not complete
      Navigator.pushReplacementNamed(context, Routes.onBoardingPath);
    } else if (!isUserLoggedIn) {
      // Navigate to login if the user is not logged in
      Navigator.pushReplacementNamed(context, Routes.loginPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonKColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30.h),
            child: RotationTransition(
              turns: rotationAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Image.asset(
                  'assets/images/movieIcon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Version 11.1.2',
            style: GoogleFonts.poppins(fontSize: 13.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void initRotatingAndScalingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(animationController);
    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    // Starting the animation
    animationController.repeat(reverse: true, period: const Duration(seconds: 4));
    animationController.forward();
  }
}
