import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/widgets/text-field.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  SearchController searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.r),
        child: Column(
          children: [
            CustomTextField(
                controller: searchController,
                label: 'Search',
                hintText: 'Search Your Movie',
                type: TextInputType.text),

                
          ],
        ),
      ),
    );
  }
}
