// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:geolog/layers/presentation/notifiers/common/viewing_screen_notifier.dart';

// ignore: must_be_immutable
class ViewingScreen extends StatelessWidget {
  String model;
  ViewingScreen({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewingScreenNotifier(model: model),
      child: const SubViewingScreen(),
    );
  }
}

class SubViewingScreen extends StatelessWidget {
  const SubViewingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ViewingScreenNotifier>();
    return SafeArea(
      child: Stack(
        children: [
          Center(
              child: BabylonJSViewer(
            src: 'https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/models//${notifier.model}',
          )),
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
        ],
      ),
    );
  }
}
