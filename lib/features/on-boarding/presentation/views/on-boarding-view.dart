import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/core/helper/cache-helper.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/features/on-boarding/presentation/views/widget/dot-indicitor.dart';
import 'package:movie/features/on-boarding/presentation/views/widget/first-page.dart';
import 'package:movie/features/on-boarding/presentation/views/widget/onboarding-button.dart';
import 'package:movie/features/on-boarding/presentation/views/widget/second-page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

var onBoardingController = PageController();
bool islast = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topEnd,
            padding: EdgeInsets.only(top: 50.h, right: 15.w),
            child: Text('Skip', style: AppTextStyle.textK16WhiteHint),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  islast = index == 1;
                });
              },
              controller: onBoardingController,
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const FirstPage();
                } else {
                  return const SecondPage();
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Text(
              !islast
                  ? 'Tell us about your favourite movie genres'
                  : 'Select the genres you like to watch',
              style: AppTextStyle.textK22FontMedium.copyWith(fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          OnBoardingButton(
            buttonHeight: 53.h,
            buttonWeidth: double.infinity,
            label: islast ? 'Finish' : 'Next',
            onTap: () {
              if (islast) {
                setState(() {
                  CacheHelper.setBoardingMode(true);
                  GoRouter.of(context).push(AppRouter.loginPath);
                });
              } else {
                onBoardingController.nextPage(
                  duration: const Duration(
                    milliseconds: 750,
                  ),
                  curve: Curves.fastLinearToSlowEaseIn,
                );
              }
            },
          ),
          SizedBox(height: 20.h),
          DotIndicator(
            currentIndex: currentIndex,
            itemCount: 2,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
