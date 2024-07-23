import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/utils/colors/colors.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const DotIndicator({
    required this.currentIndex,
    required this.itemCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 50.w,
          height: 3.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: currentIndex == index ? AppColors.buttonKColor : Colors.grey,
          ),
        );
      }),
    );
  }
}
