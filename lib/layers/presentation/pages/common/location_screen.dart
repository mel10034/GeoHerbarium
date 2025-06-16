// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: collection_methods_unrelated_type

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:geolog/layers/presentation/notifiers/common/location_notifier.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';

class LocationScreen extends StatelessWidget {
  int plantId;

  LocationScreen({
    super.key,
    required this.plantId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationNotifier(plantId),
      child: const SubLocationScreen(),
    );
  }
}

class SubLocationScreen extends StatelessWidget {
  const SubLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LocationNotifier>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Stack(
          children: [
            YandexMap(
              mapObjects: notifier.points,
              onMapCreated: (controller) {
                notifier.controller = controller;
                notifier.controller!.moveCamera(CameraUpdate.newCameraPosition(
                    const CameraPosition(
                        zoom: 3.5,
                        target: Point(latitude: 60, longitude: 100))));
              },
              nightModeEnabled: false,
              mapType: MapType.vector,
              mode2DEnabled: false,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
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
            notifier.plant != null
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // GestureDetector(
                              //   onTap: () =>
                              //       notifier.myPlaces.contains(notifier.deposit)
                              //           ? notifier.removeMyPlaces(
                              //               notifier.deposit as GeoDeposit)
                              //           : notifier.addMyPlaces(
                              //               notifier.deposit as GeoDeposit),
                              //   child: Container(
                              //     width: 50.w,
                              //     height: 50.h,
                              //     decoration: BoxDecoration(
                              //         color: MyColors.brandColor,
                              //         borderRadius: BorderRadius.circular(10)),
                              //     child: Icon(
                              //       notifier.myPlaces.contains(notifier.deposit)
                              //           ? Icons.remove
                              //           : Icons.add,
                              //       color: Colors.black,
                              //       size: 30.w,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 10.w,
                              // ),
                              GestureDetector(
                                onTap: () => notifier.close(),
                                child: Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      color: MyColors.brandColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 30.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          width: MediaQuery.of(context).size.width,
                          height: 350.h,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 24.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Text(
                                    notifier.plant!.name_ru,
                                    style: MyFontStyle.mainTitle,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 300.w,
                                      height: 150.h,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade900,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/images//${notifier.plant!.image}"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Text(
                                    notifier.deposit!.country,
                                    style: MyFontStyle.littleSubTitle,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Text(
                                    notifier.deposit!.region,
                                    style: MyFontStyle.littleSubTitle,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Text(
                                    "Описание:",
                                    style: MyFontStyle.littleSubTitle,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  child: Text(
                                    notifier.deposit!.description,
                                    style: MyFontStyle.littleSubTitle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
