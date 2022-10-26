import 'package:expectations/controllers/reset_password_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            MainToolBar(title: 'Change password'.tr, isBack: true, route: Routes.home, isProfile: false),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 20, top: 40),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 20),
                            child: Text(
                              'old password'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Const.appFont),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 20, top: 8),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GetBuilder<ChangePasswordController>(
                                  builder: (controller) => TextFormField(
                                      controller: controller.oldPassController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: controller.isVisibleOldPass,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Enter the old password here'.tr,
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: Const.appFont),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                              controller.visibleOldPassIcon),
                                          onPressed: () =>
                                              controller.visibleOldPassword(),
                                        ),
                                      ),
                                      validator: (value) =>
                                          AppHelper.validatePassword(
                                              password: value!)),
                                )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: HexColor(AppColors.blackColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 40),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 20),
                            child: Text(
                              'new password'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Const.appFont),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 8),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GetBuilder<ChangePasswordController>(
                                builder: (controller) => TextFormField(
                                    controller: controller.newPassController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: controller.isVisibleNewPass,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Enter the new password here'.tr,
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: Const.appFont),
                                      suffixIcon: IconButton(
                                        icon:
                                            Icon(controller.visibleNewPassIcon),
                                        onPressed: () =>
                                            controller.visibleNewPassword(),
                                      ),
                                    ),
                                    validator: (value) =>
                                        AppHelper.validatePassword(
                                            password: value!)),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: HexColor(AppColors.blackColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 40),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 20),
                            child: Text(
                              'Confirm Password'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Const.appFont),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 8),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GetBuilder<ChangePasswordController>(
                                builder: (controller) => TextFormField(
                                    controller:
                                        controller.confirmPassController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText:
                                        controller.isVisibleConfirmPass,
                                    decoration: InputDecoration(
                                      hintText: 'Please confirm password'.tr,
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: Const.appFont),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            controller.visibleConfirmPassIcon),
                                        onPressed: () =>
                                            controller.visibleConfirmPassword(),
                                      ),
                                    ),
                                    validator: (value) =>
                                        AppHelper.validateConfirmPassword(
                                            password: value!,
                                            conformPassword: controller
                                                .newPassController.text)),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: HexColor(AppColors.blackColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Obx(() => controller.isLoading == true
                              ? CircularProgressIndicator()
                              : Container()),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: CustomButton(
                                text: 'Change password'.tr,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontfamily: Const.appFont,
                                radius: 8,
                                background: HexColor(AppColors.defualtColor),
                                click: () => controller.resetPassword()),
                          ),
                        ],
                      ),
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
