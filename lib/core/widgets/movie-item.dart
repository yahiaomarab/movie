import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/routing/routes.dart';

class MovieItem extends StatelessWidget {
  final dynamic model;
  const MovieItem({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.homeDetailsViewPath,
            arguments: model.ID);
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500${model.image}',
                height: 170.h,
                width: 150.w,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
              Positioned(
                right: 10.w,
                bottom: 10.h,
                child: CircleAvatar(
                  backgroundColor: AppColors.secondaryKColor,
                  radius: 15.r,
                  backgroundImage: const AssetImage('assets/images/play.png'),
                ),
              ),
            ],
          ),
          Text(
            model.name,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
