import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/controllers/home_controller.dart';
import 'package:expectations/controllers/language_controller.dart';
import 'package:expectations/controllers/profile_controller.dart';
import 'package:expectations/model/profile.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ProfileController _controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'Settings', isBack: false),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  FutureBuilder(
                    future: _controller.fetchUserData(),
                      builder: (context, snapshot) {
                        // print('PROFILE IPAddress: ${AppHelper.getUserData(key: Const.KEY_USER_DATA).ipAddress}');
                        // print('PROFILE IPAddress: ${AppHelper.getRegisterData(key: Const.KEY_USER_DATA).ipAddress}');
                      if(snapshot.connectionState == ConnectionState.done)
                        return Container(
                          margin: EdgeInsetsDirectional.only(top: 30, start: 20, ),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                        'https://i.postimg.cc/B6GcTk8F/default-avatar2.png')),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: HexColor(AppColors.defualtColor))),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      '${_controller.profile.name}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: Const.appFont),
                                    ),
                                    Text(
                                      '${_controller.profile.phone}',
                                      style: TextStyle(
                                          color: HexColor(AppColors.greyColor),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: Const.appFont),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      else if(snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: Container(
                            width: 20,
                              height: 20,
                              margin: EdgeInsets.only(top: 28),
                              child: CircularProgressIndicator()),
                        );
                      else
                        return Container();
                      }),
                  Container(
                    margin: EdgeInsets.only(top: 48, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/profile.svg'),
                          SizedBox(width: 20),
                          Text(
                            'Profile'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => Get.toNamed(Routes.profile),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 48, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/lock_password.svg'),
                          SizedBox(width: 20),
                          Text(
                            'Change password'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => Get.toNamed(Routes.resetPassword),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 48, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/language.svg'),
                          SizedBox(width: 20),
                          Text(
                            'Language'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => changelangauge(context),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/notifications.svg'),
                          SizedBox(width: 20),
                          Text(
                            'Notifications'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => Get.toNamed(Routes.notifications),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, right: 24, left: 24),
                      child: GetBuilder<HomeController>(
                          builder: (home) => InkWell(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/favorite_icon.svg'),
                                    SizedBox(width: 20),
                                    Text(
                                      'Favorites'.tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont,
                                      ),
                                    ),
                                    Spacer(),
                                    SvgPicture.asset('assets/icons/arrow.svg',
                                        width: 14, height: 14),
                                  ],
                                ),
                                onTap: () {
                                  home.getCurrenNavIndex(navIndex: 2);
                                },
                              ))),
                  /*Container(
                    margin: EdgeInsets.only(top: 40, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/share_app.svg'),
                          SizedBox(width: 20),
                          Text('شارك التطبيق',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg', width: 14, height: 14),
                        ],
                      ),
                      onTap: (){
                      },
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.only(top: 40, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/contact_us.svg'),
                          SizedBox(width: 20),
                          Text(
                            'Contact Us'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => Get.toNamed(Routes.contactUs),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/about_us.svg'),
                          SizedBox(width: 20),
                          Text(
                            'About Us'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => Get.toNamed(Routes.aboutUs),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 40, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/delete.svg',
                              height: 24,
                              width: 24,
                              color: HexColor(AppColors.defualtColor)),
                          SizedBox(width: 20),
                          Text(
                            'delete_account'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => deleteAccount(context),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 40, right: 24, left: 24, bottom: 50),
                    child: InkWell(
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/sign_out.svg'),
                          SizedBox(width: 20),
                          Text(
                            'logout'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg',
                              width: 14, height: 14),
                        ],
                      ),
                      onTap: () => logout(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changelangauge(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) => AlertDialog(
          content: GetBuilder<LanguageController>(
            builder: (controller) => Container(
              width: double.infinity,
              height: 150,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Are you want to change language'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: Const.appFont),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text(
                            'English',
                            style: TextStyle(
                                color: HexColor(AppColors.defualtColor),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          onPressed: () {
                            controller.saveLang("en");
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                            child: Text(
                              'العربية',
                              style: TextStyle(
                                  color: HexColor(AppColors.blackColor),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Const.appFont),
                            ),
                            onPressed: () {
                              controller.saveLang("ar");
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void deleteAccount(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) => AlertDialog(
          content: Container(
            width: double.infinity,
            height: 180,
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  'delete_account'.tr,
                  style: TextStyle(
                      color: HexColor(AppColors.defualtColor),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: Const.appFont),
                ),
                SizedBox(height: 16),
                Text(
                  'delete_account_confirmation'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: Const.appFont),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          child: Text(
                            'Yes'.tr,
                            style: TextStyle(
                                color: HexColor(AppColors.defualtColor),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          onPressed: () {
                            HomeController controller = Get.find();
                            ApiRequests.deleteAccount(
                                token: AppHelper.getCurrentUserToken())
                                .then((value) {
                              AppHelper.clearData(key: Const.KEY_USER_TOKEN)
                                  .then((value) {
                                AppHelper.clearData(
                                    key: Const.KEY_USER_DATA)
                                    .then((value) {
                                  Get.offAndToNamed(Routes.login);
                                  controller.navIndex = 0;
                                  controller.getCurrenNavIndex(navIndex: 0);
                                });
                              });
                            }).catchError((error) {
                              print('catchError: $error');
                            });
                          }),
                      TextButton(
                          child: Text(
                            'No'.tr,
                            style: TextStyle(
                                color: HexColor(AppColors.blackColor),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) => AlertDialog(
              content: Container(
                width: double.infinity,
                height: 180,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'logout'.tr,
                      style: TextStyle(
                          color: HexColor(AppColors.defualtColor),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: Const.appFont),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Are you sure you want to sign out'.tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: Const.appFont),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              child: Text(
                                'Yes'.tr,
                                style: TextStyle(
                                    color: HexColor(AppColors.defualtColor),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: Const.appFont),
                              ),
                              onPressed: () {
                                HomeController controller = Get.find();
                                ApiRequests.logout(
                                        token: AppHelper.getCurrentUserToken())
                                    .then((value) {
                                  AppHelper.clearData(key: Const.KEY_USER_TOKEN)
                                      .then((value) {
                                    AppHelper.clearData(
                                            key: Const.KEY_USER_DATA)
                                        .then((value) {
                                      Get.offAndToNamed(Routes.login);
                                      controller.navIndex = 0;
                                      controller.getCurrenNavIndex(navIndex: 0);
                                    });
                                  });
                                }).catchError((error) {
                                  print('catchError: $error');
                                });
                              }),
                          TextButton(
                              child: Text(
                                'No'.tr,
                                style: TextStyle(
                                    color: HexColor(AppColors.blackColor),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: Const.appFont),
                              ),
                              onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

}
