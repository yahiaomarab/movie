import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/routes.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, Routes.searchViewPath);
          },
          child: CircleAvatar(
            backgroundColor: AppColors.secondaryKColor,
            radius: 25.r,
            backgroundImage: const AssetImage('assets/images/search.png'),
          ),
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
    );
  }
}
