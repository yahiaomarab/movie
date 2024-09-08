import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/features/home/domain/entity/recommended-movies/recommended-entity.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/home/presentation/view-model/recommended/recommended-states.dart';

// ignore: must_be_immutable
class RecommendedMoviesList extends StatefulWidget {
  const RecommendedMoviesList({super.key});

  @override
  State<RecommendedMoviesList> createState() => _RecommendedMoviesListState();
}

class _RecommendedMoviesListState extends State<RecommendedMoviesList> {
  List<RecommendedEntity> recommendeds = [];
  final ScrollController _scrollController = ScrollController();
  int nextPage = 2;
  bool isLoading = false;
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
      BlocProvider.of<RecommendedCubit>(context)
          .fetchRecommendedMovies(page: nextPage++)
          .then((_) {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendedCubit, RecommendedStates>(
      listener: (context, state) {
        if (state is FetchRecommendedMoviesSuccessState) {
          recommendeds.addAll(state.recmmendeds);
        } else if (state is FetchRecommendedMoviesFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failure)));
        }
      },
      builder: (context, state) {
        if (recommendeds.isEmpty &&
            state is FetchRecommendedMoviesLoadingState) {
          return const CircularProgressIndicator(); // Show initial loader.
        } else if (state is FetchRecommendedMoviesSuccessState ||
            state is FetchRecommendedMoviesPagenationLoadingState) {
          return SizedBox(
            height: 200.h,
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w500${recommendeds[index].image}',
                            height: 170.h,
                            width: 150.w,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
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
                          ),
                        ],
                      ),
                      Text(
                        recommendeds[index].name,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 5.w),
                  itemCount: recommendeds.length,
                ),
                if (state is FetchRecommendedMoviesPagenationLoadingState)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child:
                          CircularProgressIndicator(), // Loader for paginated fetch.
                    ),
                  ),
              ],
            ),
          );
        } else if (state is FetchRecommendedMoviesFailureState) {
          return const Text('Error fetching recommended movies!');
        } else {
          return const Text('No recommended movies found!');
        }
      },
    );
  }
}
