import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/router.dart';
import 'package:movie/core/utils/styles/font-style.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: AppTextStyle.textK22FontMedium,
        ),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30.sp,
            )),
      ),
      body: Container(
        margin: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.buttonKColor.withOpacity(0.5)),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.grey.withOpacity(0.5)),
              height: 172.h,
              width: double.infinity,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.profilePath);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_2_outlined,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          'Edit profile',
                          style: GoogleFonts.inter(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
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
