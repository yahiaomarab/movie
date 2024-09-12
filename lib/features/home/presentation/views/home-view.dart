import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/features/home/presentation/views/widgets/home-bar.dart';
import 'package:movie/features/home/presentation/views/widgets/list-recommended.dart';
import 'package:movie/features/home/presentation/views/widgets/trending-view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.h, left: 15.w, right: 10.w),
        child: Column(
          children: [
            const HomeBar(),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(height: 300.h, child:  const TrendingView()),
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
             const Expanded(child: RecommendedMoviesList()),
          ],
        ),
      ),
    );
  }
}
