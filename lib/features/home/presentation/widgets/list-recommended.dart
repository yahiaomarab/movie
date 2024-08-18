import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';

class RecommendedMoviesList extends StatelessWidget {
  const RecommendedMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Image.asset(
                                    'assets/images/home_image.png',
                                    height: 170.h,
                                    width: 150.w,
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
                      itemCount: 10
                      ),
    );
  }
}