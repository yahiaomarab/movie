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

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  List<RecommendedEntity> recommendeds = [];
  int nextPage = 2;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScrollExtent = _scrollController.position.pixels;
    final threshold = 0.7 * maxScrollExtent;

    if (currentScrollExtent >= threshold && !isLoading) {
      isLoading = true;
      if (mounted) {
        BlocProvider.of<RecommendedCubit>(context)
            .fetchRecommendedMovies(page: nextPage++)
            .then((_) {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController, // Use the scroll controller here
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text(
              'All Movies',
              style: AppTextStyle.textK22FontMedium,
            ),
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.h),
            sliver: BlocConsumer<RecommendedCubit, RecommendedStates>(
              listener: (context, state) {
                if (state is FetchRecommendedMoviesFailureState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.failure)));
                } else if (state is FetchRecommendedMoviesSuccessState) {
                  recommendeds.addAll(state.recommendeds);
                }
              },
              builder: (context, state) {
                if (state is FetchRecommendedMoviesSuccessState ||
                    state is FetchRecommendedMoviesPagenationLoadingState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index.isOdd) {
                          return SizedBox(height: 15.h);
                        }
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
                                'https://image.tmdb.org/t/p/w500${recommendeds[index ~/ 2].image}',
                                width: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      recommendeds[index ~/ 2].name,
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
                                      ontap: () {})
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      childCount:
                          recommendeds.length * 2 - 1, // Adjust for separators
                    ),
                  );
                } else if (state is FetchRecommendedMoviesFailureState) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('Error fetching movies')),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
