// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewScanned extends StatelessWidget {
  const ViewScanned({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Center(
              child: BabylonJSViewer(
            src: 'assets/cube/mint.glb',
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
