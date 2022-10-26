import 'package:expectations/controllers/forget_password_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  ForgetPasswordController _controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _controller.formKeyPassword,
        child: Column(
          children: [
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                  color: HexColor(AppColors.defualtColor),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r))),
              child: Container(
                margin: EdgeInsets.only(top: 25.r),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    InkWell(
                        child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        onTap: () => Get.offAndToNamed(Routes.login)),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        'forgot password'.tr,
                        style: TextStyle(
                            color: HexColor(AppColors.whiteColor),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: Const.appFont),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.r, right: 20.r),
                      padding: EdgeInsets.only(left: 10.r),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password Reset'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Enter the email associated with your account and we will send an email with instructions to reset your password.'
                                .tr,
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 20.r, top: 20.r),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'email'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Const.appFont),
                            ),
                            margin: EdgeInsetsDirectional.only(start: 20.r),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 8).r,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8).r,
                                child: GetBuilder<ForgetPasswordController>(
                                  builder: (controller) => TextFormField(
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        hintText: 'example@example.com',
                                        hintStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: Const.appFont),
                                        suffixIcon: IconButton(
                                          icon: Icon(controller.clearDataIcon),
                                          onPressed: () =>
                                              controller.clearData(),
                                        ),
                                      ),
                                      validator: (value) =>
                                          AppHelper.validateEmail(
                                              email: value!)),
                                )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: HexColor(AppColors.blackColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: [
                        Obx(() => controller.isLoading == true
                            ? CircularProgressIndicator()
                            : Container()),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 20.w),
                          child: CustomButton(
                              text: 'send'.tr,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              fontfamily: Const.appFont,
                              radius: 8.r,
                              background: HexColor(AppColors.defualtColor),
                              click: () => controller.forgetPassword()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
