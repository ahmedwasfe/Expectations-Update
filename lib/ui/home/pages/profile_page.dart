import 'dart:convert';
import 'dart:io';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/api/purchases_api.dart';
import 'package:expectations/controllers/home_controller.dart';
import 'package:expectations/controllers/language_controller.dart';
import 'package:expectations/controllers/profile_controller.dart';
import 'package:expectations/model/profile.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/ui/widget/pay_wall_widget.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          MainToolBar(title: 'Settings', isBack: false, isProfile: false),
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
                        if (snapshot.connectionState == ConnectionState.done)
                          return Container(
                            margin: EdgeInsetsDirectional.only(
                              top: 30,
                              start: 20,
                            ),
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
                                          color: HexColor(
                                              AppColors.defualtColor))),
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
                                            color:
                                                HexColor(AppColors.greyColor),
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
                        else if (snapshot.connectionState ==
                            ConnectionState.waiting)
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
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: HexColor(AppColors.defualtColor),
                          )
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
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
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
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
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
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
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
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        size: 20,
                                        color: HexColor(AppColors.defualtColor))
                                  ],
                                ),
                                onTap: () {
                                  home.getCurrenNavIndex(navIndex: 3);
                                },
                              ))),
                  Container(
                    margin: EdgeInsets.only(top: 40, right: 24, left: 24),
                    child: InkWell(
                      child: Row(
                        children: [
                          Image.asset('assets/icons/subscriber.png'),
                          SizedBox(width: 20),
                          Text(
                            'subscribe'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
                        ],
                      ),
                      onTap: () async {
                        if(Platform.isAndroid)
                          Get.toNamed(Routes.packages);
                        else{
                          // showSubscriptionBottomSheet(context, Text('Subscribe'));
                          await PurchasesApi.purchaesProduct('com.example.expectations.monthlyPlan35');
                        }
                      }
                    ),
                  ),
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
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
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
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
                        ],
                      ),
                      onTap: () => Get.toNamed(Routes.aboutUs),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40, right: 24, left: 24),
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
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
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
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: HexColor(AppColors.defualtColor))
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

  void showSubscriptionBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 320,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 50,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(height: 20),
                Text(''),
                SizedBox(height: 14),
                SizedBox(height: 20),
                widget,
                SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  static void showLoginDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) => AlertDialog(
              clipBehavior: Clip.antiAlias,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                height: 300.h,
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsetsDirectional.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Container(
                        margin: EdgeInsets.only(top: 8.r),
                        height: 150.h,
                        width: 230.w,
                        child: Image.asset('assets/images/login.png',
                            fit: BoxFit.cover)),
                    Spacer(),
                    Container(
                        child: CustomButton(
                            height: 52,
                            background: Colors.black,
                            text: 'login'.tr,
                            click: () => Get.offAndToNamed(Routes.login))),
                  ],
                ),
              ),
            ));
  }

  void changelangauge(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) => AlertDialog(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: GetBuilder<LanguageController>(
                builder: (controller) => Container(
                  width: 350,
                  height: 180,
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsetsDirectional.only(top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
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
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                text: 'english'.tr,
                                textColor: AppHelper.getAppLanguage() == 'en'
                                    ? Colors.white
                                    : HexColor(AppColors.defualtColor),
                                height: 48,
                                width: 100,
                                radius: 8,
                                borderWidth:
                                    AppHelper.getAppLanguage() == 'en' ? 0 : 1,
                                background: AppHelper.getAppLanguage() == 'en'
                                    ? HexColor(AppColors.defualtColor)
                                    : HexColor(AppColors.backgroundColor),
                                isUpperCase: false,
                                borderColor: AppHelper.getAppLanguage() == 'en'
                                    ? AppColors.defualtColor
                                    : AppColors.defualtColor,
                                click: () {
                                  controller.saveLang("en");
                                  Navigator.pop(context);
                                }),
                            CustomButton(
                                text: 'arabic'.tr,
                                textColor: AppHelper.getAppLanguage() == 'ar'
                                    ? Colors.white
                                    : HexColor(AppColors.defualtColor),
                                height: 48,
                                width: 100,
                                radius: 8,
                                borderWidth:
                                    AppHelper.getAppLanguage() == 'ar' ? 0 : 1,
                                background: AppHelper.getAppLanguage() == 'ar'
                                    ? HexColor(AppColors.defualtColor)
                                    : HexColor(AppColors.backgroundColor),
                                isUpperCase: false,
                                borderColor: AppHelper.getAppLanguage() == 'ar'
                                    ? AppColors.defualtColor
                                    : AppColors.defualtColor,
                                click: () {
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
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: Container(
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsetsDirectional.only(top: 10.r),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r)),
                width: 350,
                height: 250,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'delete_account'.tr,
                      style: TextStyle(
                          color: HexColor(AppColors.defualtColor),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
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
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                              text: 'delete'.tr,
                              textColor: Colors.white,
                              height: 48,
                              width: 100,
                              radius: 8,
                              background: HexColor(AppColors.defualtColor),
                              isUpperCase: false,
                              borderColor: AppColors.defualtColor,
                              click: () {
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
                          CustomButton(
                              text: 'cancel'.tr,
                              textColor: HexColor(AppColors.defualtColor),
                              height: 48,
                              width: 100,
                              radius: 8,
                              borderWidth: 1,
                              background: HexColor(AppColors.backgroundColor),
                              isUpperCase: false,
                              borderColor: AppColors.defualtColor,
                              click: () {
                                Navigator.pop(context);
                              }),
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
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: Container(
                width: 380,
                height: 250,
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'logout'.tr,
                      style: TextStyle(
                          color: HexColor(AppColors.defualtColor),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
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
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                              text: 'logout'.tr,
                              textColor: Colors.white,
                              height: 48,
                              width: 130,
                              radius: 8,
                              background: HexColor(AppColors.defualtColor),
                              isUpperCase: false,
                              borderColor: AppColors.defualtColor,
                              click: () {
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
                          CustomButton(
                              text: 'cancel'.tr,
                              textColor: HexColor(AppColors.defualtColor),
                              height: 48,
                              width: 100,
                              radius: 8,
                              borderWidth: 1,
                              background: HexColor(AppColors.backgroundColor),
                              isUpperCase: false,
                              borderColor: AppColors.defualtColor,
                              click: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
