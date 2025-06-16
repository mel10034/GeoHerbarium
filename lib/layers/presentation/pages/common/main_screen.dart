// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolog/layers/presentation/pages/common/create_plant_page.dart';

import 'package:geolog/layers/presentation/pages/common/home_screen.dart';
import 'package:geolog/layers/presentation/pages/common/profile_screen.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  int selectIndex = 0;
  MainPage({
    super.key,
    required this.selectIndex,
  });

  @override
  State<MainPage> createState() => _mainSreenCompanyState();
}

class _mainSreenCompanyState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  late PageController _pageController;
  late List<Widget> _screens;
  late int _index;

  @override
  void initState() {
    super.initState();

    _index = 0;
    _screens = [
      const HomeScreen(),
      const ProfileScreen()
    ];
    _pageController = PageController(initialPage: _index);
  }

  void _onTap(int index) {
    setState(() {
      _index = index;
      _pageController.jumpToPage(_index);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: Supabase.instance.client.auth.currentUser!
                      .userMetadata?['role'] ==
                  "admin"
              ? GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const CreatePlantPage())),
                  child: Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                        color: MyColors.brandColor,
                        borderRadius: BorderRadius.circular(15.w)),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 32.w,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          backgroundColor: Colors.black,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              unselectedLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
              onTap: _onTap,
              currentIndex: widget.selectIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              selectedLabelStyle: const TextStyle(color: Colors.white),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/image/home.svg',
                    colorFilter: ColorFilter.mode(
                        widget.selectIndex == 0 ? Colors.white : Colors.white,
                        BlendMode.srcIn),
                  ),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/image/profile.svg',
                    colorFilter: ColorFilter.mode(
                        widget.selectIndex == 2 ? Colors.white : Colors.white,
                        BlendMode.srcIn),
                  ),
                  label: 'Профиль',
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
