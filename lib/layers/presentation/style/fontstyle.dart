import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolog/layers/presentation/style/colors.dart';

abstract class MyFontStyle {
   static TextStyle hugeTitle =  TextStyle(fontSize: 30.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.white);
   static TextStyle hugeBrandTitle =  TextStyle(fontSize: 30.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: MyColors.brandColor);
    static TextStyle mainTitle =  TextStyle(fontSize: 24.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.white);
    static TextStyle subMainTitle =  TextStyle(fontSize: 26.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.white);
    static TextStyle nameTitle =  TextStyle(fontSize: 20.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.white);
     static TextStyle littleSubTitle =  TextStyle(fontSize: 15.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.white);
     static TextStyle littleSubTitleActive =  TextStyle(fontSize: 15.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.grey.shade900);
    static TextStyle subTitle =  TextStyle(fontSize: 16.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.white);
    static TextStyle subTitleBlack =  TextStyle(fontSize: 16.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.black);
    static TextStyle label =  TextStyle(fontSize: 12.sp,fontFamily: 'Lufga',fontWeight: FontWeight.w600,color: Colors.white);
}