import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget toast(String text, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width.w / 1.2.w,
    decoration: BoxDecoration(
        color: Colors.grey[850], borderRadius: BorderRadius.circular(10.w)),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 15.w,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
            const Spacer(),
            Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(4.w)),
              child: SvgPicture.asset(
                'assets/image/error.svg',
                colorFilter: ColorFilter.mode(
                    Colors.grey[850] as Color, BlendMode.srcIn),
              ),
            ),
            SizedBox(
              width: 15.w,
            )
          ],
        ),
      ),
    ),
  );
}
