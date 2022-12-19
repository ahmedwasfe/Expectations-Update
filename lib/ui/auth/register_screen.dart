import 'package:expectations/controllers/register_controller.dart';
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
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends GetView<RegisterController> {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
      body: Form(
        key: controller.formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 50.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 65.r),
                    child: Image.asset(
                      'assets/icons/logo41.png',
                      width: 133.w,
                      height: 121.6.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Create an account".tr,
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: '${Const.appFont}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24).r,
                    child: Text(
                        'Please fill out this form to create your account!'.tr,
                        style: TextStyle(
                          color: HexColor(AppColors.subTextColor),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: '${Const.appFont}',
                        ),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 20.h),
                  ////////////////////////////////////////////////////////////////////////////////////////////
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "full name".tr,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: '${Const.appFont}'),
                            ),
                            SizedBox(height: 8.r),
                            Container(
                              height: 40.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .r,
                                child: TextFormField(
                                  controller: controller.nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Please write your full name (first and last name)'
                                            .tr,
                                  ),
                                  validator: (value) =>
                                      AppHelper.validateName(name: value!),
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
                              "date of birth".tr,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: '${Const.appFont}'),
                            ),
                            SizedBox(height: 8.h),
                            InkWell(
                              child: Container(
                                height: 40.h,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0).r,
                                  child: TextFormField(
                                    controller: controller.birthDateController,
                                    keyboardType: TextInputType.datetime,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'choose your age'.tr,
                                      enabled: true,
                                      suffixIcon: IconButton(
                                        icon: SvgPicture.asset(
                                            'assets/icons/icon_date.svg'),
                                        onPressed: () {},
                                      ),
                                    ),
                                    validator: (value) =>
                                        AppHelper.validateDateOfBirth(
                                            dateOfBirth: value),
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
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: controller.date,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                                if (newDate == null) return;
                                controller.date = newDate;
                                int year = controller.date.year;
                                int month = controller.date.month;
                                int day = controller.date.day;
                                controller.birthDateController.text =
                                    '$year-$month-$day';
                              },
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
                              "Email Address",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: '${Const.appFont}'),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              height: 40.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .r,
                                child: TextFormField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Enter the email'.tr,
                                  ),
                                  validator: (value) =>
                                      AppHelper.validateEmail(email: value),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .r,
                                child: GetBuilder<RegisterController>(
                                  builder: (controller) => TextFormField(
                                    controller: controller.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: controller.isVisiblePass,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Password'.tr,
                                        suffixIcon: IconButton(
                                          icon:
                                              Icon(controller.visiblePassIcon),
                                          onPressed: () =>
                                              controller.visiblePassword(),
                                        )),
                                    validator: (value) =>
                                        AppHelper.validatePassword(
                                            password: value!),
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
                              "Confirm Password".tr,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: '${Const.appFont}'),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              height: 40.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .r,
                                child: GetBuilder<RegisterController>(
                                  builder: (controller) => TextFormField(
                                    controller:
                                        controller.confirmPasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText:
                                        controller.isVisibleConfirmPass,
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password'.tr,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            controller.visibleConfirmPassIcon),
                                        onPressed: () =>
                                            controller.visibleConfirmPassword(),
                                      ),
                                    ),
                                    validator: (value) =>
                                        AppHelper.validateConfirmPassword(
                                            password: controller
                                                .passwordController.text,
                                            conformPassword: value!),
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
                              "Address".tr,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: '${Const.appFont}'),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              height: 40.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .r,
                                child: TextFormField(
                                  controller: controller.addressController,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your preferred address'.tr,
                                  ),
                                  validator: (value) =>
                                      AppHelper.validateAddress(
                                          address: value!),
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
                              "phone number".tr,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: '${Const.appFont}'),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              height: 40.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .r,
                                child: Container(
                                  margin: EdgeInsets.only(top: 16.r),
                                  child: IntlPhoneField(
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 0),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: 343.w,
                                        maxHeight: 90.h,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                    initialCountryCode: 'SA',
                                    onChanged: (phone) {
                                      controller.phoneController.text =
                                          phone.completeNumber;
                                      print(phone.completeNumber);
                                      print(controller.phoneController.text);
                                    },
                                    validator: (value) =>
                                        AppHelper.validatePhone(
                                            phone: value!.completeNumber),
                                  ),
                                ),

                                /*TextFormField(
                                  controller: controller.phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your phone number'.tr,
                                  ),
                                  validator: (value) =>
                                      AppHelper.validatePhone(
                                          phone: value!),
                                ),*/
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
                              "athletic inclinations".tr,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: '${Const.appFont}'),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              height: 40.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0)
                                        .r,
                                child: TextFormField(
                                  controller: controller.sportsController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter your athletic inclination'.tr,
                                  ),
                                  validator: (value) {},
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
                    ],
                  ),
                  ////////////////////////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 18.h),
                  Obx(() => controller.isLoading == true
                      ? CustomProgress()
                      : Container()),
                  Container(
                    height: 48.h,
                    margin: EdgeInsets.only(top: 20.r, left: 30.r, right: 30.r),
                    child: CustomButton(
                      text: 'Create an account'.tr,
                      textColor: HexColor(AppColors.whiteColor),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      fontfamily: '${Const.appFont}',
                      radius: 8.r,
                      background: HexColor(AppColors.defualtColor),
                      click: () => controller.createAccount(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'I already have an account'.tr,
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
                          onTap: () => Get.offAllNamed('/login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
