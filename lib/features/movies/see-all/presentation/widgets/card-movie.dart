import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie/core/utils/colors/colors.dart';
import 'package:movie/core/utils/styles/font-style.dart';
import 'package:movie/core/utils/widgets/button.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: HexColor('#25233d'),
                    ),
                    padding: EdgeInsets.all(15.h),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/background.jpg',
                          width: MediaQuery.of(context).size.width * 0.3,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  'Captin America: The Winter Soldier',
                                  style: AppTextStyle.textK13ForMovieName,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
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
                                ontap: (){})
                          ],
                        )
                      ],
                    ),
                  );
  }
}