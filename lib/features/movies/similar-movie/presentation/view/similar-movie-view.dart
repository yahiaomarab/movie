import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/funcitons/service-locator.dart';
import 'package:movie/features/movies/similar-movie/data/repo/similar-movie-repo-impl.dart';
import 'package:movie/features/movies/similar-movie/domain/entity/similar-movie-entity.dart';
import 'package:movie/features/movies/similar-movie/domain/use-case/similar-movie-use-case.dart';
import 'package:movie/features/movies/similar-movie/presentation/view-model/cubit.dart';
import 'package:movie/features/movies/similar-movie/presentation/view-model/states.dart';

class SimilarMovieView extends StatefulWidget {
  const SimilarMovieView({super.key, required this.id});
  final int id;
  
  @override
  State<SimilarMovieView> createState() => _SimilarMovieViewState();
}

class _SimilarMovieViewState extends State<SimilarMovieView> {
  List<SimilarMovieEntity> similars = [];
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
      BlocProvider.of<SimilarMovieCubit>(context)
          .fetchSimilarMovie(id: widget.id,page: nextPage++)
          .then((_) {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SimilarMovieCubit(
          SimilarMovieUseCase(locator<SimilarMovieRepoImpl>()))
        ..fetchSimilarMovie(id: widget.id),
      child: BlocConsumer<SimilarMovieCubit, SimilarMovieStates>(
        listener: (context, state) {
          if (state is GetSimilarMovieFailureState) {
            const SnackBar(
              content: Text('error in fetching data'),
            );
          } else if (state is GetSimilarMoviesSuccessState) {
            similars.addAll(state.similarMovieEntity);
          }
        },
        builder: (context, state) {
          if (state is GetSimilarMoviesSuccessState ||
              state is GetSimilarMoviePagenationLoadingState) {
               return SizedBox(
              height: 50.h,
              child: ListView.separated(
                controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${similars[index].image}',
                        width: 53.w,
                        fit: BoxFit.cover,
                      )),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 5.w,
                      ),
                  itemCount: similars.length),
            );
          }else if (state is GetSimilarMovieFailureState){
            return Center(child: Text('Failure ${state.failure.toString()}'));
          }else{
            return const Text('No similar movie found');
          }
        },
      ),
    );
  }
}
