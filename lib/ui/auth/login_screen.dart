import 'package:expectations/controllers/login_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    if (AppHelper.getUserData(key: Const.KEY_USER_DATA) != null) {
      print(
          "LoginScreen: ${AppHelper.getUserData(key: Const.KEY_USER_DATA).name}");
    }

    // controller.emailController.text = 'ahmet.mandil@gmail.com';
    // controller.passwordController.text = '12345678';

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: controller.formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 65.r),
                  child: Image.asset(
                    'assets/icons/logo41.png',
                    width: 150.w,
                    height: 150.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Login".tr,
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: '${Const.appFont}'),
                ),
                // SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12).r,
                  child: Text(
                      'Log in with the data you entered during registration.'
                          .tr,
                      style: TextStyle(
                        color: HexColor(AppColors.subTextColor),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: '${Const.appFont}',
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "email".tr,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: '${Const.appFont}'),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 40.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
                          child: TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter the email'.tr,
                            ),
                            validator: (value) =>
                                AppHelper.validateEmail(email: value!),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              width: 1.r,
                              style: BorderStyle.solid,
                              color: HexColor(AppColors.blackColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password".tr,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: '${Const.appFont}'),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 40.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
                          child: GetBuilder<LoginController>(
                            builder: (controller) => TextFormField(
                              controller: controller.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: controller.isVisiblePass,
                              decoration: InputDecoration(
                                hintText: 'Enter Password'.tr,
                                suffixIcon: IconButton(
                                  icon: Icon(controller.visiblePassIcon),
                                  onPressed: () => controller.visiblePassword(),
                                ),
                              ),
                              validator: (value) =>
                                  AppHelper.validatePassword(password: value!),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              width: 1.r,
                              style: BorderStyle.solid,
                              color: HexColor(AppColors.blackColor)),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: InkWell(
                          child: Text(
                            "Forgot your password?".tr,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: '${Const.appFont}',
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () => Get.toNamed(Routes.forgetPassword),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => controller.isLoading == true
                    ? CircularProgressIndicator()
                    : Container()),
                Container(
                  margin: EdgeInsets.only(top: 40.r, left: 30.r, right: 30.r),
                  child: CustomButton(
                    height: 48.h,
                    text: 'Login'.tr,
                    textColor: HexColor(AppColors.whiteColor),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    fontfamily: '${Const.appFont}',
                    radius: 8.r,
                    background: HexColor(AppColors.defualtColor),
                    click: () => controller.login(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Do not have an account?'.tr,
                        style: TextStyle(
                            color: HexColor(AppColors.subTextColor),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: Const.appFont),
                      ),
                      SizedBox(width: 4.w),
                      InkWell(
                        child: Text(
                          'Create an account'.tr,
                          style: TextStyle(
                              color: HexColor(AppColors.blackColor),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: Const.appFont),
                        ),
                        onTap: () => Get.toNamed('/register'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
