import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/widgets/text-field.dart';
import 'package:movie/core/widgets/movie-item.dart';
import 'package:movie/features/search/presentation/view-model/search-cubit.dart';
import 'package:movie/features/search/presentation/view-model/search-states.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  ScrollController scrollController = ScrollController();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if (state is FetchSearchDataFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.r),
            child: Column(
              children: [
                CustomTextField(
                  controller: searchController,
                  label: 'Search',
                  hintText: 'Search Your Movie',
                  type: TextInputType.text,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      SearchCubit.get(context).fetchSearchData(query: val);
                    }
                  },
                  onSubmit: (val) {
                    if (val!.isNotEmpty) {
                      SearchCubit.get(context).fetchSearchData(query: val);
                    }
                  },
                ),
                
                // Check for loading state
                if (state is FetchSearchDataLoadingState)
                  Center(child: CircularProgressIndicator()),

                // Check for failure state
                if (state is FetchSearchDataFailureState)
                  Expanded(
                    child: Center(
                      child: Text(
                        'An error occurred: ${state.failure}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),

                // Show search results or fallback background image
                if (SearchCubit.get(context).isSearch && state is FetchSearchDataSuccessState)
                  Expanded(
                    child: GridView.count(
                      controller: scrollController,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 3,
                      children: List.generate(
                        SearchCubit.get(context).searchList.length,
                        (index) => MovieItem(
                          model: SearchCubit.get(context).searchList[index],
                        ),
                      ),
                    ),
                  ),
                if (!SearchCubit.get(context).isSearch)
                  Expanded(
                    child: Image.asset(
                      'assets/images/background.jpg',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
