import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/widgets/button.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Set<int> selectedIndices = {};
  List<String> buttons = [
    'Action',
    'Adventure',
    'Adventures',
    'Drama',
    'Comedy',
    'Crime',
    'Documentary',
    'Sports',
    'Fantasy',
    'Horror',
    'Music',
    'Western',
    'Horror',
    'Thriller',
    'Sci-fi',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 130.h, right: 20.w, left: 20.w),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.w, // space between items horizontally
          runSpacing: 8.h, // space between items vertically
          children: buttons.asMap().entries.map((entry) {
            int index = entry.key;
            String text = entry.value;
            return IntrinsicWidth(
              child: IntrinsicHeight(
                child: CustomButton(
                  buttonCircular: 4.r,
                  buttonColor: selectedIndices.contains(index)
                      ? AppColors.buttonKColor
                      : HexColor('1E1E1E'),
                  buttonHeight: 32.h,
                  buttonWeidth: 72.w,
                  label: text,
                  labelSize: 10.sp,
                  labelColor: AppColors.whiteKColor,
                  ontap: () {
                    setState(() {
                      if (selectedIndices.contains(index)) {
                        selectedIndices.remove(index);
                      } else {
                        selectedIndices.add(index);
                      }
                    });
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
