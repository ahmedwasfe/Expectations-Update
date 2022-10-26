import 'package:expectations/api/api_requests.dart';
import 'package:expectations/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  IconData clearDataIcon = Icons.clear;

  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void omInit() {
    // formKeyPassword = GlobalKey<FormState>();
    // emailController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    formKeyPassword.currentState!.dispose();
    emailController.dispose();
    super.dispose();
  }

  void clearData() {
    emailController.clear();
    update();
  }

  void forgetPassword() {
    bool isValidate = formKeyPassword.currentState!.validate();
    if (isValidate) {
      print('EMAIL: ${emailController.text}');
      isLoading(true);
      ApiRequests.forgetpassword(email: emailController.text).then((value) {
        // isLoading(true);
        Get.snackbar('sent'.tr, value!.data!);
        Get.toNamed(Routes.login);
        isLoading(false);
      }).catchError((error) {
        isLoading(false);
        print('catchError: $error');
      });
    } else
      isLoading(false);
  }
}
