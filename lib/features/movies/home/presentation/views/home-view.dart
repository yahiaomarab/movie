import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/core/utils/routing/routes.dart';
import 'package:movie/features/movies/home/data/repos/home-repo.dart';
import 'package:movie/features/movies/home/domain/use-case/recommended-use-case.dart';
import 'package:movie/features/movies/home/domain/use-case/trending-use-case.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/movies/home/presentation/view-model/trending/trending-cubit.dart';
import 'package:movie/features/movies/home/presentation/views/widgets/home-bar.dart';
import 'package:movie/features/movies/home/presentation/views/widgets/list-recommended.dart';
import 'package:movie/features/movies/home/presentation/views/widgets/trending-view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TrendingCubit(
                  TrendingUseCase(locator.get<HomeRepoImpl>()),
                )..fetchTrendingMovies()),
        BlocProvider(
            create: (context) => RecommendedCubit(
                  RecommendedUseCase(locator.get<HomeRepoImpl>()),
                )..fetchRecommendedMovies()),
      ],
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 30.h, left: 15.w, right: 10.w),
          child: Column(
            children: [
              const HomeBar(),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(height: 300.h, child: const TrendingView()),
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
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.seeAllPath);
                      },
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
      ),
    );
  }
}
