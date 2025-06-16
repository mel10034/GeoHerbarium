// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:geolog/layers/presentation/notifiers/common/home_notifier.dart';
import 'package:geolog/layers/presentation/pages/common/about_plant.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeNotifier(),
      child: const SubHomeScreen(),
    );
  }
}

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key});

  @override
  State<SubHomeScreen> createState() => _SubHomeScreenState();
}

class _SubHomeScreenState extends State<SubHomeScreen>
    with AutomaticKeepAliveClientMixin<SubHomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    'Растения',
                    style: MyFontStyle.mainTitle,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const SearchField(),
                SizedBox(
                  height: 10.h,
                ),
                const PLantTypeField(),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const PLants(),
                SizedBox(
                  height: 70.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PLants extends StatelessWidget {
  const PLants({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<HomeNotifier>();
    return notifier.plants.isEmpty && !notifier.isLoading
                ? const Center(
                    child: Text(
                      "Растений нет",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                :
    
    ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: notifier.isLoading ? 5 : notifier.plants.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: notifier.isLoading
            ? const ShimmerPlantsItem()
            :  PLantsItem(index: index),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<HomeNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 45.h,
        child: CupertinoTextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(30),
          style: const TextStyle(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) => notifier.searchPlants(value),
          placeholder: "Поиск...",
          placeholderStyle: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
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
    final notifier = context.watch<HomeNotifier>();

    return Center(
      child: Container(
        width: 300.w,
        height: 45.h,
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
                        "Фильтр по типу",
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
                            notifier.searchByType(notifier.plant_type);
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

// ignore: must_be_immutable
class PLantsItem extends StatelessWidget {
  int index;
  PLantsItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<HomeNotifier>();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutPlant(
                plant: notifier.plants[index].id,
              ))),
      child: Column(
        children: [
          Container(
            width: 300.w,
            height: 140.h,
            decoration: BoxDecoration(
                color: MyColors.brandColor,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/images//${notifier.plants[index].image}"),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          ),
          Container(
            width: 300.w,
            height: 55.h,
            decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  notifier.plants[index].name_ru,
                  style: MyFontStyle.littleSubTitle,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => notifier.favorites.any(
                          (item) => item.plant_id == notifier.plants[index].id)
                      ? notifier.removeFavorite(notifier.plants[index])
                      : notifier.addFavorite(notifier.plants[index]),
                  child: SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: SvgPicture.asset(
                        'assets/image/favorite.svg',
                        colorFilter: ColorFilter.mode(
                            notifier.favorites.any((item) =>
                                    item.plant_id == notifier.plants[index].id)
                                ? MyColors.brandColor
                                : Colors.grey.shade500,
                            BlendMode.srcIn),
                      )),
                ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerPlantsItem extends StatelessWidget {
  const ShimmerPlantsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: MyColors.brandColor,
          highlightColor: MyColors.subBrandColor,
          child: Container(
            width: 300.w,
            height: 140.h,
            decoration: BoxDecoration(
                color: MyColors.brandColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          ),
        ),
        Container(
          width: 300.w,
          height: 55.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              Shimmer.fromColors(
                  baseColor: MyColors.brandColor,
                  highlightColor: MyColors.subBrandColor,
                  child: Container(
                    width: 80.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5)),
                  )),
              const Spacer(),
              SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: SvgPicture.asset(
                    'assets/image/favorite.svg',
                    colorFilter:
                        ColorFilter.mode(Colors.grey.shade900, BlendMode.srcIn),
                  )),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
