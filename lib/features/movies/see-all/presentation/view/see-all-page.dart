import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/features/movies/see-all/presentation/widgets/card-movie.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-cubit.dart';
import 'package:movie/features/movies/home/presentation/view-model/recommended/recommended-states.dart';

// ignore: must_be_immutable
class SeeAllPage extends StatelessWidget {
  SeeAllPage({super.key});
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int nextPage = 2;

  void _scrollListener(BuildContext context) {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final currentScrollExtent = scrollController.position.pixels;
    final threshold = 0.7 * maxScrollExtent;

    if (currentScrollExtent >= threshold && !isLoading) {
      isLoading = true;
      // Fetch the next page of recommended movies
      BlocProvider.of<RecommendedCubit>(context)
          .fetchRecommendedMovies(page: nextPage++)
          .then((_) {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() => _scrollListener(context));

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,  // Use the scroll controller here
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
            sliver: BlocBuilder<RecommendedCubit, RecommendedStates>(
              builder: (context, state) {
                if (state is FetchRecommendedMoviesSuccessState) {
                  final recommendeds = state.recommendeds;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index.isOdd) {
                          return SizedBox(height: 15.h);
                        }
                        return MovieCard(
                          index: index ~/ 2, // Adjust for the separators
                          scrollController: scrollController,
                        );
                      },
                      childCount: recommendeds.length * 2 - 1, // Adjust for separators
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
          // If in loading state, show a loading indicator at the bottom of the list
          BlocBuilder<RecommendedCubit, RecommendedStates>(
            builder: (context, state) {
              if (state is FetchRecommendedMoviesPagenationLoadingState) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
            },
          ),
        ],
      ),
    );
  }
}
