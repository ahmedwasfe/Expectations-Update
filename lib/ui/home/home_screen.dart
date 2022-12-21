import 'package:expectations/controllers/home_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/ui/home/pages/home_page.dart';
import 'package:expectations/ui/home/pages/profile_page.dart';
import 'package:expectations/ui/home/pages/test.dart';
import 'package:expectations/ui/live/live_screen.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'pages/expections_page.dart';
import 'pages/favorite_page.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppHelper.statusBarColor(isHome: true);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: HexColor(AppColors.defualtColor)));
  print('HOME TOKEN: ${AppHelper.getUserToken(key: Const.KEY_USER_TOKEN)}');
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: controller.navIndex,
                  children: [
                    //  ChangeLanguagee(),
                    HomePage(),
                    ExpectionsPage(),
                    Live(),
                    FavoritePage(),
                    ProfilePage(),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                child: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: HexColor(AppColors.defualtColor),
                  currentIndex: controller.navIndex,
                  items: _bottomNavigationBarItems(),
                  onTap: (navIndex) => controller.getCurrenNavIndex(context: context, navIndex: navIndex),
                ),
                decoration: BoxDecoration(
                    color: HexColor(AppColors.bottomNavColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        topLeft: Radius.circular(20.r))),
              ),
            ));
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems() => [
        // BottomNavigationBarItem(
        //     icon: Icon(CupertinoIcons.home), label: "اللغة"),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), label: "Main".tr),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_3), label: "My Expectations".tr),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add), label: "live".tr),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart), label: "Favorites".tr),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person), label: "Profile".tr),
      ];
}
