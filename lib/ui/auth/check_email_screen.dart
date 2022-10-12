import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Container(
              margin: EdgeInsets.only(top: 25.r),
              child: Row(
                children: [
                  SizedBox(width: 20.w),
                  InkWell(
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        color: Colors.black,
                      ),
                      onTap: () => Get.offAndToNamed(Routes.forgetPassword)),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/check_email.svg'),
                  Container(
                    margin: EdgeInsets.all(20.r),
                    child: Text(
                      "Verify your email ".tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: Const.appFont),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.r),
                    child: Text(
                      'We have sent password recovery instructions to your email.'
                          .tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: HexColor(AppColors.subTextColor),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: Const.appFont),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.r),
                    child: CustomButton(
                        text: 'Open the email app'.tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        fontfamily: Const.appFont,
                        background: HexColor(AppColors.defualtColor),
                        radius: 8.r,
                        click: () {}),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.r),
                    child: InkWell(
                      child: Text(
                        'Skip, I will confirm later'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: HexColor(AppColors.subTextColor),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: Const.appFont),
                      ),
                      onTap: () => Get.offAndToNamed(Routes.login),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.r),
                    child: InkWell(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:
                                'Did not receive email? Check your spam filter'
                                    .tr,
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                            children: [
                              TextSpan(
                                onEnter: (va) {
                                  print(va);
                                },
                                text: 'Try another email address'.tr,
                                style: TextStyle(
                                    color: HexColor(AppColors.blackColor),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: Const.appFont),
                              ),
                            ]),
                      ),
                      onTap: () => Get.offAndToNamed(Routes.forgetPassword),
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
}
