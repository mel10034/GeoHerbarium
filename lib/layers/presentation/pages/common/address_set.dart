import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolog/layers/presentation/notifiers/common/adress_set_notifier.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SetAddressPage extends StatelessWidget {
  const SetAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SetaddresspageNotifier(),
      child: const SubSetAddressPage(),
    );
  }
}

class SubSetAddressPage extends StatelessWidget {
  const SubSetAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SetaddresspageNotifier>();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            "Местность произрастания",
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
        body: YandexMap(
          onMapTap: (point) {
            notifier.chooseAdress(point);
          },
          mapObjects: notifier.mapObjects,
          onMapCreated: (controller) async {
            notifier.controller = controller;

            notifier.controller!.moveCamera(
                CameraUpdate.newCameraPosition(const CameraPosition(
                    target: Point(
                      latitude: 51.768199,
                      longitude: 55.096955,
                    ),
                    zoom: 14)),
                animation: const MapAnimation(duration: 1));
          },
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
        ),
        floatingActionButton: Row(
          children: [
            const Spacer(),
            const BackArrow(),
            notifier.choosedPoint != null
                ? Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      const SetPosition(),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(30.w)),
        width: 55.w,
        height: 55.h,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SetPosition extends StatelessWidget {
  const SetPosition({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SetaddresspageNotifier>();
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(notifier.choosedPoint),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(30.w)),
        width: 55.w,
        height: 55.h,
        child: const Icon(
          Icons.fmd_good_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
