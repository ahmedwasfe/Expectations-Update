import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

class AppAdvantagesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
            'application_advantages'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
              color: HexColor(AppColors.defualtColor),),
            textAlign: TextAlign.center),
        toolbarHeight: 80.h,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 23,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                fit: BoxFit.cover,
                  'assets/images/boarding1.png',
                  height: 200.h),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 18.r, end: 18.r),
              child: Text(
                'register_with_us'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: '${Const.appFont}',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50.h),
            Container(
              width: double.infinity,
              child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/boarding2.png',
                  height: 200.h),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 8.r, end: 8.r),
              child: Text(
                'activate_your_subscription'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: '${Const.appFont}',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50.h),
            Container(
              width: double.infinity,
              child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/boarding3.png',
                  height: 200.h),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 8.r, end: 8.r),
              child: Text(
                'predict_the_result'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: '${Const.appFont}',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}