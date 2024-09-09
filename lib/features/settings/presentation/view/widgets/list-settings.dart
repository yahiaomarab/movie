import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildListItem({
  required IconData icon, // Renamed to avoid conflict
  required String title,
  required String routerPath, // Add type for routerPath
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      GoRouter.of(context).push(routerPath);
    },
    child: Row(
      children: [
        Icon(
          icon,
        ),
        SizedBox(
          width: 20.w,
        ),
        Text(
          title, 
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}