import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/core/utils/colors/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    initRotatingAndScalingAnimation();
    goToOnBoardingPage();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonKColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30.h),
            height: MediaQuery.of(context).size.height*0.9,
            width: double.infinity,
            child: RotationTransition(
              turns: rotationAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Image.asset(
                  'assets/images/movieIcon.png',
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Text('Version 11.1.2',style: GoogleFonts.poppins(fontSize: 13.sp,color: Colors.white),),
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
    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    animationController.repeat(reverse: true, period: const Duration(seconds: 4));
    animationController.forward();
  }

  void goToOnBoardingPage() {
    Future.delayed(const Duration(seconds: 5), () {
      GoRouter.of(context).push(
        AppRouter.layoutPath,
      );
    });
  }
}
