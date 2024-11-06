import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/styles/font-style.dart';

class TVTrending extends StatelessWidget {
  const TVTrending({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/tvbackground.png',
          height: MediaQuery.of(context).size.height * .5,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.4,
          margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Column(
                children: [
                  Text(
                    'New episodes • Season 4',
                    style: AppTextStyle.textK12ForSeason,
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      'STRANGER THINGS',
                      style: GoogleFonts.cinzelDecorative(
                        fontSize: 30.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 25.w),
                      _buildInfoTag('16+'),
                      SizedBox(width: 15.w),
                      _buildInfoTag('Science Fiction'),
                      SizedBox(width: 15.w),
                      _buildInfoTag('Netflix'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      height: 20.h,
      decoration: BoxDecoration(
        color: AppColors.buttonKColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
