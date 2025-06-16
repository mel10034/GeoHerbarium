// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolog/layers/presentation/pages/common/about_plant.dart';
import 'package:provider/provider.dart';
import 'package:geolog/layers/presentation/notifiers/common/profile_notifier.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileNotifier(),
      child: const SubProfileScreen(),
    );
  }
}

class SubProfileScreen extends StatelessWidget {
  const SubProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
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
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () => notifier.logOut(context),
                        child: SvgPicture.asset(
                          'assets/image/logout.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        )),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                notifier.isLoading ? const AvatarShimmer() : const Avatar(),
                SizedBox(
                  height: 20.h,
                ),
                const NameLabel(),
                SizedBox(
                  height: 25.h,
                ),
                const ActionBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionBar extends StatefulWidget {
  const ActionBar({super.key});
  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 1,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            labelColor: Colors.grey.shade900,
            labelStyle: MyFontStyle.littleSubTitleActive,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: MyFontStyle.littleSubTitle,
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
                color: MyColors.brandColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            tabs: const [
              Tab(
                text: "Избранное",
              ),
              // Tab(
              //   text: "Мои места",
              // ),
            ]),
        SizedBox(
          height: 500.h,
          child: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              Favorites(),

              // MyPlaces()
            ],
          ),
        ),
      ],
    );
  }
}

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
      child: Wrap(
        direction: Axis.horizontal,
        children: List.generate(
          notifier.isLoading ? 6 : notifier.favorites.length,
          (index) => Padding(
            padding: EdgeInsets.only(
                bottom: 24.h, right: index % 2 == 0 ? 18.w : 0.w),
            child: notifier.isLoading
                ? const FavoritesShimmerItem()
                : FavoritesItem(
                    index: index,
                  ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FavoritesItem extends StatelessWidget {
  int index;
  FavoritesItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              AboutPlant(plant: notifier.favorites[index].plant_id))),
      child: Column(
        children: [
          SizedBox(
            width: 150.w,
            height: 100.h,
            child: Stack(
              children: [
                Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/images//${notifier.myFavorites[index].image}"),
                          fit: BoxFit.cover)),
                ),
                GestureDetector(
                  onTap: () => notifier
                      .removeFavorite(notifier.favorites[index].plant_id),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        const Spacer(),
                        Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade900,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: SvgPicture.asset(
                                'assets/image/favorite.svg',
                                colorFilter: ColorFilter.mode(
                                    MyColors.brandColor, BlendMode.srcIn),
                              ),
                            )),
                        SizedBox(
                          width: 12.w,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 150.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                SizedBox(
                  width: 120.w,
                  child: Text(
                    notifier.myFavorites[index].name_ru,
                    style: MyFontStyle.littleSubTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesShimmerItem extends StatelessWidget {
  const FavoritesShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 150.w,
          height: 100.h,
          child: Stack(
            children: [
              Shimmer.fromColors(
                baseColor: MyColors.brandColor,
                highlightColor: MyColors.subBrandColor,
                child: Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade900,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: SvgPicture.asset(
                            'assets/image/favorite.svg',
                            colorFilter: ColorFilter.mode(
                                MyColors.brandColor, BlendMode.srcIn),
                          ),
                        )),
                    SizedBox(
                      width: 12.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 150.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              Shimmer.fromColors(
                  baseColor: MyColors.brandColor,
                  highlightColor: MyColors.subBrandColor,
                  child: Container(
                    width: 70.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5)),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class MyPlaces extends StatelessWidget {
  const MyPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: notifier.isLoading ? 4 : notifier.myPlaces.length,
        itemBuilder: (BuildContext context, int index) => notifier.isLoading
            ? Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: const MyPlacesShimmerItem(),
              )
            : Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: MyPlacesItem(
                  index: index,
                ),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyPlacesItem extends StatelessWidget {
  int index;
  MyPlacesItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              AboutPlant(plant: notifier.favorites[index].plant_id))),
      child: Column(
        children: [
          SizedBox(
            width: 280.w,
            height: 100.h,
            child: Stack(
              children: [
                Container(
                  width: 280.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://ybtmhmcuudcbiojupcnw.supabase.co/storage/v1/object/public/images//${notifier.myPlaces[index].image}"),
                          fit: BoxFit.cover)),
                ),
                GestureDetector(
                  onTap: () => notifier.removeMyPlace(notifier.myPlaces[index]),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        const Spacer(),
                        Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade900,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: SvgPicture.asset(
                                'assets/image/favorite.svg',
                                colorFilter: ColorFilter.mode(
                                    MyColors.brandColor, BlendMode.srcIn),
                              ),
                            )),
                        SizedBox(
                          width: 12.w,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 280.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  notifier.myPlaces[index].name,
                  style: MyFontStyle.littleSubTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyPlacesShimmerItem extends StatelessWidget {
  const MyPlacesShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 280.w,
          height: 100.h,
          child: Stack(
            children: [
              Shimmer.fromColors(
                baseColor: MyColors.brandColor,
                highlightColor: MyColors.subBrandColor,
                child: Container(
                  width: 280.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade900,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: SvgPicture.asset(
                            'assets/image/favorite.svg',
                            colorFilter: ColorFilter.mode(
                                MyColors.brandColor, BlendMode.srcIn),
                          ),
                        )),
                    SizedBox(
                      width: 12.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 280.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              Shimmer.fromColors(
                  baseColor: MyColors.brandColor,
                  highlightColor: MyColors.subBrandColor,
                  child: Container(
                    width: 70.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(5)),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class NameLabel extends StatelessWidget {
  const NameLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
    return Center(
        child: notifier.isLoading
            ? Shimmer.fromColors(
                baseColor: MyColors.brandColor,
                highlightColor: MyColors.subBrandColor,
                child: Container(
                  width: 80.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                ))
            : Text(
                notifier.nickname,
                style: MyFontStyle.nameTitle,
              ));
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfileNotifier>();
    return Center(
      child: notifier.bytes != null
          ? Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: MemoryImage(notifier.bytes as Uint8List),
                      fit: BoxFit.cover),
                  color: Colors.grey[900],
                  shape: BoxShape.circle),
            )
          : Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                  color: Colors.grey[900], shape: BoxShape.circle),
            ),
    );
  }
}

class AvatarShimmer extends StatelessWidget {
  const AvatarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.brandColor,
      highlightColor: MyColors.subBrandColor,
      child: Center(
        child: Container(
          width: 150.w,
          height: 150.h,
          decoration:
              BoxDecoration(color: Colors.grey[900], shape: BoxShape.circle),
        ),
      ),
    );
  }
}
