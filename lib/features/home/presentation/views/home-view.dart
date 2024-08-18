import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.h, left: 15.w, right: 10.w),
        child: Column(
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Hey, Sarthak\n', // Adding a newline character
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                      TextSpan(
                        text: 'Karangamal >',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.buttonKColor,
                          decoration: TextDecoration.none,
                        ),
                        onEnter: (l) {},
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: AppColors.secondaryKColor,
                  radius: 25.r,
                  backgroundImage: const AssetImage('assets/images/search.png'),
                ),
                SizedBox(
                  width: 13.w,
                ),
                CircleAvatar(
                  backgroundColor: AppColors.secondaryKColor,
                  radius: 25.r,
                  backgroundImage: const AssetImage('assets/images/person.png'),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 300.h,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: 265.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48.r),
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomButton(
                          buttonCircular: 26.r,
                          buttonColor: AppColors.secondaryKColor,
                          buttonHeight: 30.h,
                          buttonWeidth: 110.w,
                          label: 'Watch Trailer >>',
                          fontWeight: FontWeight.w400,
                          labelSize: 12.sp,
                          labelColor: Colors.white,
                          ontap: () {},
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 110.h,
                          width: 315.w,
                          padding: EdgeInsets.only(
                              top: 20.h, bottom: 10.h, left: 25.w, right: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(58.r),
                            color: AppColors.secondaryKColor,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trending',
                                    style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'EVIL DEAD RISE',
                                    style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'A .English',
                                    style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'HORHOR',
                                    style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                      buttonCircular: 30.r,
                                      buttonColor: Colors.white,
                                      buttonHeight: 40.h,
                                      buttonWeidth: 75.w,
                                      label: 'Book',
                                      labelSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      labelColor: Colors.white,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF323232), // Color at 0%
                                          Color(0xFF767676), // Color at 49%
                                          Color(0xFF363535), // Color at 100%
                                        ],
                                        stops: [
                                          0.0,
                                          0.49,
                                          1.0
                                        ], // Percentages for each color stop
                                        begin: Alignment
                                            .topCenter, // Start of the gradient
                                        end: Alignment
                                            .bottomCenter, // End of the gradient
                                      ),
                                      ontap: () {}),
                                  Text(
                                    '2D.3D.4DX',
                                    style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text(
                  'Recommended Movies',
                  style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All >',
                      style: GoogleFonts.inter(
                          color: AppColors.buttonKColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    )),
              ],
            ),
            SizedBox(
              height: 200.h,
              child: Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Image.asset(
                                  'assets/images/movie.png',
                                  height: 170.h,
                                  width: 150.w,
                                  color: Colors.red,
                                ),
                                Positioned(
                                  right: 20.w,
                                  bottom: 10.h,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.secondaryKColor,
                                    radius: 15.r,
                                    backgroundImage: const AssetImage(
                                        'assets/images/play.png'),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Flash (2023)',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 5.w,
                        ),
                    itemCount: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
