import 'dart:convert';
import 'dart:io';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/api/purchases_api.dart';
import 'package:expectations/model/Packages/packages.dart';
import 'package:expectations/model/Packages/payment.dart';
import 'package:expectations/model/register.dart';
import 'package:expectations/model/user.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/ui/widget/pay_wall_widget.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterController extends GetxController {
  String ipAddress = '';

  RxBool isLoading = false.obs;

  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController birthDateController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController sportsController;

  DateTime date = DateTime(2022, 5, 29);

  bool isVisiblePass = true;
  bool isVisibleConfirmPass = true;

  IconData visiblePassIcon = Icons.visibility;
  IconData visibleConfirmPassIcon = Icons.visibility;

  @override
  void onInit() {
    getIPAddress();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    birthDateController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    sportsController = TextEditingController();
    super.onInit();
  }

  @override
  dispose() {
    nameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    phoneController.dispose();
    sportsController.dispose();
    super.dispose();
  }

  void visiblePassword() {
    isVisiblePass = !isVisiblePass;
    visiblePassIcon = isVisiblePass ? Icons.visibility : Icons.visibility_off;
    update();
  }

  void visibleConfirmPassword() {
    isVisibleConfirmPass = !isVisibleConfirmPass;
    visibleConfirmPassIcon =
        isVisibleConfirmPass ? Icons.visibility : Icons.visibility_off;
    update();
  }

  Future getIPAddress() async {
    await ApiRequests.getIPAddress().then((value) {
      if (value != null) ipAddress = value;

      print("IP ADDRESS: $ipAddress");
    });
  }

  void createAccount() {
    print("createAccount: ${phoneController.text}");
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      isLoading(true);
      ApiRequests.createAccount(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
              confirmPassword: confirmPasswordController.text,
              phone: phoneController.text,
              dateOfBirth: birthDateController.text,
              address: addressController.text,
              ipAddress: ipAddress,
              fcmToken: AppHelper.getUserToken(key: Const.KEY_FIREBASE_TOKEN))
          .then((value) {
        if (value != null) {
          Register register = value;
          String expiredDate = register.data!.exDate!;
          print('IPADDRESS: ${register.data!.ipAddress}');
          if(expiredDate != null && expiredDate != ""){
            if(AppHelper.getDateTody() == expiredDate)
              goTo(register, Routes.packages);
            else
              goTo(register, Routes.home);
          }else
            goTo(register, Routes.home);

          formKey.currentState!.save();
          isLoading(false);
        } else {
          isLoading(false);
        }
      }).catchError((error) {
        isLoading(false);
        print("catchError: $error");
      });
    } else
      isLoading(false);
  }


  void goTo(Register register, String route) {
    AppHelper.saveUserToken(
        key: Const.KEY_USER_TOKEN, token: register.data!.token!);
    AppHelper.saveRegisterUserData(
        key: Const.KEY_USER_DATA, registerData: register.data!);
    AppHelper.saveAppData(
        key: Const.KEY_LOGIN_REGISTER, value: Const.Value_Register);
    Get.offAndToNamed(route);
  }
}
