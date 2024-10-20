import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';
import 'package:movie/features/movies/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-states.dart';

// ignore: must_be_immutable
class MovieCard extends StatefulWidget {
  final int index; 
  final ScrollController scrollController;

  const MovieCard({super.key, required this.index, required this.scrollController});  

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  List<RecommendedEntity> recommendeds = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedCubit, RecommendedStates>(
      builder: (context, state) {
        if (state is FetchRecommendedMoviesSuccessState) {
          recommendeds = state.recommendeds;

          return Container(
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: HexColor('#25233d'),
            ),
            padding: EdgeInsets.all(15.h),
            child: Row(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${recommendeds[widget.index].image}',
                  width: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        recommendeds[widget.index].name,
                        style: AppTextStyle.textK13ForMovieName,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Action, Adventure',
                      style: AppTextStyle.textK12WhiteHint,
                    ),
                    const Spacer(),
                    CustomButton(
                      buttonCircular: 10.r,
                      buttonColor: AppColors.buttonKColor,
                      buttonHeight: 20.h,
                      buttonWeidth: 120.w,
                      label: ' Watch Now ',
                      labelSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      labelColor: Colors.white,
                      ontap: () {}
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return const SizedBox();  // Return an empty widget in case of error
        }
      },
    );
  }
}
