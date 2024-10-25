import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.asset(
              'assets/images/tvbackground.png',
              height: MediaQuery.of(context).size.height * .5,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 10.sp,
                            )),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert_sharp,
                              color: Colors.white,
                              size: 10.sp,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'New episodes • Season 4',
                        style: AppTextStyle.textK12ForSeason,
                      ),
                      SizedBox(height: 15.h),
                      Container(
                          width: 250.w,
                          child: Text(
                            'STRANGER THINGS',
                            style: GoogleFonts.cinzelDecorative(
                                fontSize: 30.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 25.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: AppColors.buttonKColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Text(
                              '16+',
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: AppColors.buttonKColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Science Fiction',
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: AppColors.buttonKColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Netflix',
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomButton(
                        gradient: AppColors.customGradient,
                          buttonCircular: 20.r,
                          buttonColor: Colors.white,
                          buttonHeight: 58.h,
                          buttonWeidth: double.infinity,
                          label: 'Continue Watch',
                          labelColor: Colors.white,
                          ontap: (){}),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
