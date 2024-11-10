import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/features/tv/home/data/repos/tv-airing-repo.dart';
import 'package:movie/features/tv/home/data/repos/tv-popular-repo.dart';
import 'package:movie/features/tv/home/domain/use-case/tv-airing-use-case.dart';
import 'package:movie/features/tv/home/domain/use-case/tv-popular-use-case.dart';
import 'package:movie/features/tv/home/presentation/view-model/airing/cubit.dart';
import 'package:movie/features/tv/home/presentation/view-model/popular/cubit.dart';
import 'package:movie/features/tv/home/presentation/view/widgets/tv-popular.dart';
import 'package:movie/features/tv/home/presentation/view/widgets/tv-airing.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TvPopularCubit(
            TvPopularUseCase(locator.get<TvPopularRepoImpl>()),
          )..fetchTvPopularData(),
        ),
          BlocProvider(
          create: (context) => TvAiringCubit(
            TvAiringUseCase(locator.get<TvAiringRepoImpl>()),
          )..fetchTvAiringData(),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TVAiring(),
            SizedBox(height: 50.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Popular ',
                      style: AppTextStyle.textK14FontRegular,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'See all',
                    style: GoogleFonts.inter(
                      color: AppColors.buttonKColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            const TVPopular(),
          ],
        ),
      ),
    );
  }
}
