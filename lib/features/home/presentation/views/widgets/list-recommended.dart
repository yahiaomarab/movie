import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-states.dart';

// ignore: must_be_immutable
class RecommendedMoviesList extends StatelessWidget {
  RecommendedMoviesList({super.key});
  List<RecommendedEntity> recommendeds = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendedCubit, RecommendedStates>(
      listener: (context, state) {
        if (state is FetchRecommendedMoviesSuccessState) {
          recommendeds.addAll(state.recmmendeds);
        } else if (state is FetchRecommendedMoviesFailureState) {
          SnackBar(content: Text(state.failure));
        }
      },
      builder: (context, state) {
        if (state is FetchRecommendedMoviesSuccessState &&
            state.recmmendeds.isNotEmpty) {
          return SizedBox(
            height: 200.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500${state.recmmendeds[index].image}',
                              height: 170.h,
                              width: 150.w,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                            ),
                            Positioned(
                              right: 20.w,
                              bottom: 10.h,
                              child: CircleAvatar(
                                backgroundColor: AppColors.secondaryKColor,
                                radius: 15.r,
                                backgroundImage:
                                    const AssetImage('assets/images/play.png'),
                              ),
                            )
                          ],
                        ),
                        Text(
                          state.recmmendeds[index].name,
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
                itemCount: state.recmmendeds.length),
          );
        } else if (state is FetchRecommendedMoviesFailureState) {
          return const Text('Error fetching recommended movies!');
        } else if (state is FetchRecommendedMoviesLoadingState) {
          return const CircularProgressIndicator();
        } else {
          return const Text('No recommended movies found!');
        }
      },
    );
  }
}
