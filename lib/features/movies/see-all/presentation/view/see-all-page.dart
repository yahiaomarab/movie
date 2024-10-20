import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/features/movies/see-all/presentation/widgets/card-movie.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isOdd) {
                    return SizedBox(height: 15.h);
                  }

                  return const MovieCard();
                },
                childCount: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
