// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:geolog/layers/presentation/pages/common/edit_plant.dart';
import 'package:geolog/layers/presentation/pages/common/location_screen.dart';
import 'package:geolog/layers/presentation/pages/common/viewing_screen.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:geolog/layers/presentation/notifiers/common/about_plant_notifier.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

// ignore: must_be_immutable
class AboutPlant extends StatelessWidget {
  int plant;
  AboutPlant({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutPlantNotifier(favoritePlant: plant),
      child: const SubAboutPlant(),
    );
  }
}

class SubAboutPlant extends StatelessWidget {
  const SubAboutPlant({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AboutPlantNotifier>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: notifier.plant == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                      child: CircularProgressIndicator(
                    color: MyColors.brandColor,
                  )),
                  const Spacer()
                ],
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          width: 400.w,
                          height: 400.h,
                          child: Center(
                            child: BabylonJSViewer(
                              src:
                                  'https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/models//${notifier.plant?.model}',
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
                        Column(
                          children: [
                            SizedBox(
                              height: 7.h,
                            ),
                            Supabase.instance.client.auth.currentUser!
                                        .userMetadata?['role'] ==
                                    "admin"
                                ? Row(
                                    children: [
                                      const Spacer(),
                                      const DeletePLant(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      const EditPLant(),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: Supabase.instance.client.auth.currentUser!
                                          .userMetadata?['role'] ==
                                      "admin"
                                  ? 260.h
                                  : 315.h,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => ViewingScreen(
                                                model: notifier.plant!.model,
                                              ))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.w, top: 16.h),
                                    child: SvgPicture.asset(
                                        'assets/image/explore.svg'),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.plant!.name_ru,
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
                        notifier.plant!.name_latin.toString(),
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
                        notifier.plant!.genus == null
                            ? "Не определён"
                            : notifier.genus,
                        style: MyFontStyle.littleSubTitle,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const MapPoint(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Описание:',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        notifier.description,
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
                        notifier.plant!.origin,
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
                        notifier.plant!.family == null
                            ? "Не определено"
                            : notifier.family,
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
                        notifier.plant!.habitat == null
                            ? "Не определено"
                            : notifier.habitat,
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
                        notifier.plant!.plant_type == null
                            ? "Не определено"
                            : notifier.plant_type,
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
                        notifier.plant!.source == null
                            ? "Не определено"
                            : notifier.plant!.source.toString(),
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
                        notifier.plant!.life_cycle == null
                            ? "Не определено"
                            : notifier.life_cycle,
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

class MapPoint extends StatelessWidget {
  const MapPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AboutPlantNotifier>();
    return GestureDetector(
      onTap: notifier.plant == null
          ? null
          : () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LocationScreen(
                        plantId: notifier.plant!.id,
                      )));
            },
      child: Center(
          child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[850], borderRadius: BorderRadius.circular(30.w)),
        height: 150.h,
        width: 330.w,
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: YandexMap(
              onMapTap: 
              notifier.plant == null
          ? null
          :
              (Point) async {
                await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LocationScreen(plantId: notifier.plant!.id,)));
              },
              onMapCreated: (controller) async {},
            ),
          ),
        ),
      )),
    );
  }
}

class DeletePLant extends StatelessWidget {
  const DeletePLant({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AboutPlantNotifier>();
    return GestureDetector(
      onTap: () => notifier.removePlant(notifier.plant as Plant, context),
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 24.w,
        ),
      ),
    );
  }
}

class EditPLant extends StatelessWidget {
  const EditPLant({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AboutPlantNotifier>();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => EditPLantPage(
                plant: notifier.plant as Plant,
              ))),
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 24.w,
        ),
      ),
    );
  }
}
