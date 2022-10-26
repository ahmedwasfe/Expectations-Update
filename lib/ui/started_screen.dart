import 'package:expectations/controllers/boarding_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StartedScreen extends GetView<BoardingsController> {

  BoardingsController _controller = Get.put(BoardingsController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
      body: FutureBuilder(
        future: _controller.fetchBoardings(),
        builder: (context, snapshot) =>  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo41.png',
                width: 200.w,
                height: 200.h,
              ),
              SizedBox(height: 20),
              Text(
                AppHelper.getAppLanguage() == "ar" ? '${controller.listBoardings[3].title}' : '${controller.listBoardings[7].title}',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: '${Const.appFont}'),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40).r,
                child: Text(
                    AppHelper.getAppLanguage() == "ar" ? '${controller.listBoardings[3].description}' : '${controller.listBoardings[7].description}',
                    style: TextStyle(
                      color: HexColor(AppColors.subTextColor),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: '${Const.appFont}',
                    ),
                    textAlign: TextAlign.center),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.r, left: 30.r, right: 30.r),
                child: CustomButton(
                  height: 48.h,
                    text: 'start now'.tr,
                    textColor: HexColor(AppColors.whiteColor),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    fontfamily: '${Const.appFont}',
                    radius: 8.r,
                    background: HexColor(AppColors.defualtColor),
                    click: () => Get.toNamed(Routes.register)),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Do you have an account?'.tr,
                      style: TextStyle(
                          color: HexColor(AppColors.subTextColor),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Const.appFont),
                    ),
                    SizedBox(width: 4.w),
                    InkWell(
                      child: Text(
                        'Login'.tr,
                        style: TextStyle(
                            color: HexColor(AppColors.blackColor),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: Const.appFont),
                      ),
                      onTap: () => Get.toNamed(Routes.login),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                child: Text(
                  'skip'.tr,
                  style: TextStyle(
                      color: HexColor(AppColors.blackColor),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: Const.appFont),
                ),
                onTap: () => Get.toNamed(Routes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
