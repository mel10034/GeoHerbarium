// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolog/layers/presentation/notifiers/common/about_scanned_notifier.dart';
import 'package:geolog/layers/presentation/pages/common/view_scanned.dart';
import 'package:provider/provider.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';

// ignore: must_be_immutable
class AboutScanned extends StatelessWidget {
  const AboutScanned({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutScannedNotifier(),
      child: const SubAboutStone(),
    );
  }
}

class SubAboutStone extends StatelessWidget {
  const SubAboutStone({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    width: 400.w,
                    height: 400.h,
                    child: Center(
                      child: BabylonJSViewer(
                        src: 'assets/cube/mint.glb',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w, top: 16.h),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 30.w,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 315.h),
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const ViewScanned())),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w, top: 16.h),
                            child: SvgPicture.asset('assets/image/explore.svg'),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Мята перечная",
                  style: MyFontStyle.mainTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Латинское название:',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Mentha piperita",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Род:',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Мята (Mentha)",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Происхождение:',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Средиземноморье",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Семейство:',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Яснотковые (Lamiaceae)",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Среда обитания:',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Луг",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Тип растения:',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Трава",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Источник:',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Лекарственные растения",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Жизненный цикл',
                  style: MyFontStyle.subTitle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "Многолетнее",
                  style: MyFontStyle.littleSubTitle,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
