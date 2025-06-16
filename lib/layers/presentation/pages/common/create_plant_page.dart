// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolog/layers/presentation/notifiers/common/create_plant_page_notifier.dart';
import 'package:geolog/layers/presentation/pages/common/address_set.dart';
import 'package:geolog/layers/presentation/pages/common/main_screen.dart';
import 'package:geolog/layers/presentation/pages/common/toast.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CreatePlantPage extends StatelessWidget {
  const CreatePlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreatePlantPageNotifier(),
      child: const SubCreatePlantPage(),
    );
  }
}

class SubCreatePlantPage extends StatelessWidget {
  const SubCreatePlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Создание',
                        style: MyFontStyle.mainTitle,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    const ImagePick(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const FilePickButton(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const NameRuField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const NameLatinField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const FamilyField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const GenusField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const PLantTypeField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const LifeCycleField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const HabitatField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const SourceField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const OriginField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const DescriptionField(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Местонахождение растения',
                        style: MyFontStyle.mainTitle,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Выберите местонахождение',
                        style: MyFontStyle.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const MapPoint(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const CountryField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const RegionField(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const DescriptionRegionField(),
                    SizedBox(
                      height: 110.h,
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.h),
                    child: const CreatePlantButton(),
                  )),
            ],
          )),
    );
  }
}

class MapPoint extends StatelessWidget {
  const MapPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return GestureDetector(
      onTap: () async {
        final value = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SetAddressPage()));

        if (value != null) {
          notifier.setPoint(value);
        }
      },
      child: Center(
          child: Container(
        decoration: BoxDecoration(
            color: notifier.point == null ? Colors.red : MyColors.brandColor,
            borderRadius: BorderRadius.circular(30.w)),
        height: 150.h,
        width: 300.w,
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: YandexMap(
              onMapTap: (Point) async {
                final value = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SetAddressPage()));

                if (value != null) {
                  notifier.setPoint(value);
                }
              },
              onMapCreated: (controller) async {},
            ),
          ),
        ),
      )),
    );
  }
}

class ImagePick extends StatelessWidget {
  const ImagePick({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return GestureDetector(
      onTap: () => notifier.pickImage(context),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(15.w),
              image: notifier.profileImage == null
                  ? null
                  : DecorationImage(
                      image: MemoryImage(
                        notifier.profileImage as Uint8List,
                      ),
                      fit: BoxFit.cover)),
          width: 300.w,
          height: 160.h,
          child: notifier.profileImage != null
              ? const SizedBox()
              : Icon(
                  Icons.image_not_supported,
                  color: Colors.grey.shade400,
                  size: 24.w,
                ),
        ),
      ),
    );
  }
}

class FilePickButton extends StatelessWidget {
  const FilePickButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return GestureDetector(
      onTap: () async => await notifier.pickFile(),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(10.w)),
          width: 300.w,
          height: 60.h,
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              Text(
                notifier.fileName != null
                    ? notifier.fileName as String
                    : 'Выберите 3D модель (.glb)',
                style: TextStyle(
                    color: notifier.fileName != null
                        ? Colors.white
                        : Colors.grey.shade400,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreatePlantButton extends StatelessWidget {
  const CreatePlantButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: notifier.file == null ||
                  notifier.pickedFile == null ||
                  notifier.name_ru.isEmpty ||
                  notifier.name_latin.isEmpty ||
                  notifier.family == 0 ||
                  notifier.genus == 0 ||
                  notifier.plant_type == 0 ||
                  notifier.life_cycle == 0 ||
                  notifier.habitat == 0 ||
                  notifier.description.isEmpty ||
                  notifier.origin.isEmpty ||
                  notifier.source.isEmpty ||
                  notifier.country.isEmpty ||
                  notifier.descriptionRegion.isEmpty ||
                  notifier.region.isEmpty ||
                  notifier.point == null
              ? () {
                  FToast fToast = FToast();
                  fToast.init(context);
                  fToast.showToast(
                      gravity: ToastGravity.TOP,
                      toastDuration: const Duration(seconds: 2),
                      child: toast("Все поля должны быть заполнены", context));
                }
              : () async {
                  await notifier.createPlant();
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (context) => MainPage(selectIndex: 0)),
                      (r) => false);
                },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(MyColors.brandColor),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: notifier.isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                    color: Colors.black,
                  ))
              : Text(
                  'Создать',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Lufga',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
        ),
      ),
    );
  }
}

class NameRuField extends StatelessWidget {
  const NameRuField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.name_ru = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Наименование на русском",
              labelText: "Наименование на русском",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class CountryField extends StatelessWidget {
  const CountryField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.country = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Страна",
              labelText: "Страна",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class RegionField extends StatelessWidget {
  const RegionField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.region = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Регион",
              labelText: "Регион",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class DescriptionRegionField extends StatelessWidget {
  const DescriptionRegionField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.descriptionRegion = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Описание среды обитания",
              labelText: "Описание среды обитания",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class NameLatinField extends StatelessWidget {
  const NameLatinField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.name_latin = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Наименование на латинском",
              labelText: "Наименование на латинском",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class SourceField extends StatelessWidget {
  const SourceField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.source = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Источник",
              labelText: "Источник",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class OriginField extends StatelessWidget {
  const OriginField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.origin = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Происхождение",
              labelText: "Происхождение",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: TextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            notifier.description = value;
            notifier.notify();
          },
          decoration: InputDecoration(
              focusColor: Colors.grey[850],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[850] as Color)),
              fillColor: Colors.grey[850],
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              hintText: "Описание",
              labelText: "Описание",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
        ),
      ),
    );
  }
}

class FamilyField extends StatelessWidget {
  const FamilyField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();

    return Center(
      child: Container(
        width: 300.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.w),
          color: Colors.grey[850],
          child: Center(
            child: ValueListenableBuilder<String>(
                valueListenable: notifier.dropFamilyValue,
                builder: (BuildContext context, String value, _) {
                  return DropdownButtonFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    dropdownColor: Colors.grey[850],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 4.h),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                    ),
                    isExpanded: true,
                    hint: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "Семейство",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey,
                        size: 20.w,
                      ),
                    ),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (choice) {
                      if (choice != null) {
                        for (int i = 0; i < notifier.families.length; i++) {
                          if (choice.toString() == notifier.families[i].name) {
                            notifier.family = notifier.families[i].id;
                            notifier.notify();
                          }
                        }
                        notifier.dropFamilyValue.value = choice.toString();
                      }
                    },
                    items: notifier.familiesStrings
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class GenusField extends StatelessWidget {
  const GenusField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();

    return Center(
      child: Container(
        width: 300.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.w),
          color: Colors.grey[850],
          child: Center(
            child: ValueListenableBuilder<String>(
                valueListenable: notifier.dropGenusValue,
                builder: (BuildContext context, String value, _) {
                  return DropdownButtonFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    dropdownColor: Colors.grey[850],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 4.h),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                    ),
                    isExpanded: true,
                    hint: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "Род",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey,
                        size: 20.w,
                      ),
                    ),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (choice) {
                      if (choice != null) {
                        for (int i = 0; i < notifier.genuses.length; i++) {
                          if (choice.toString() == notifier.genuses[i].name) {
                            notifier.genus = notifier.genuses[i].id;
                            notifier.notify();
                          }
                        }
                        notifier.dropGenusValue.value = choice.toString();
                      }
                    },
                    items: notifier.genusesStrings
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class PLantTypeField extends StatelessWidget {
  const PLantTypeField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();

    return Center(
      child: Container(
        width: 300.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.w),
          color: Colors.grey[850],
          child: Center(
            child: ValueListenableBuilder<String>(
                valueListenable: notifier.dropPLantTypeValue,
                builder: (BuildContext context, String value, _) {
                  return DropdownButtonFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    dropdownColor: Colors.grey[850],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 4.h),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                    ),
                    isExpanded: true,
                    hint: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "Тип растения",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey,
                        size: 20.w,
                      ),
                    ),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (choice) {
                      if (choice != null) {
                        for (int i = 0; i < notifier.plant_types.length; i++) {
                          if (choice.toString() ==
                              notifier.plant_types[i].name) {
                            notifier.plant_type = notifier.plant_types[i].id;
                            notifier.notify();
                          }
                        }
                        notifier.dropPLantTypeValue.value = choice.toString();
                      }
                    },
                    items: notifier.plant_typesStrings
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class LifeCycleField extends StatelessWidget {
  const LifeCycleField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();

    return Center(
      child: Container(
        width: 300.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.w),
          color: Colors.grey[850],
          child: Center(
            child: ValueListenableBuilder<String>(
                valueListenable: notifier.dropLifeCycleValue,
                builder: (BuildContext context, String value, _) {
                  return DropdownButtonFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    dropdownColor: Colors.grey[850],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 4.h),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                    ),
                    isExpanded: true,
                    hint: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "Жизненный цикл",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey,
                        size: 20.w,
                      ),
                    ),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (choice) {
                      if (choice != null) {
                        for (int i = 0; i < notifier.life_cycles.length; i++) {
                          if (choice.toString() ==
                              notifier.life_cycles[i].name) {
                            notifier.life_cycle = notifier.life_cycles[i].id;
                            notifier.notify();
                          }
                        }
                        notifier.dropLifeCycleValue.value = choice.toString();
                      }
                    },
                    items: notifier.life_cyclesStrings
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class HabitatField extends StatelessWidget {
  const HabitatField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CreatePlantPageNotifier>();

    return Center(
      child: Container(
        width: 300.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.w),
          color: Colors.grey[850],
          child: Center(
            child: ValueListenableBuilder<String>(
                valueListenable: notifier.dropHabitatValue,
                builder: (BuildContext context, String value, _) {
                  return DropdownButtonFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    dropdownColor: Colors.grey[850],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 4.h),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: BorderSide(
                              color: Colors.grey[850] as Color, width: 2.5.w)),
                    ),
                    isExpanded: true,
                    hint: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        "Среда обитания",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey,
                        size: 20.w,
                      ),
                    ),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (choice) {
                      if (choice != null) {
                        for (int i = 0; i < notifier.habitats.length; i++) {
                          if (choice.toString() == notifier.habitats[i].name) {
                            notifier.habitat = notifier.habitats[i].id;
                            notifier.notify();
                          }
                        }
                        notifier.dropHabitatValue.value = choice.toString();
                      }
                    },
                    items: notifier.habitatsStrings
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
