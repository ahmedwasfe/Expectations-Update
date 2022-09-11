import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {


  Locale? getAppLocale() {
    String? language = AppHelper.getAppData(key: Const.KEY_LANGUAGE);
    if (language == "ar")
      return Locale("ar");
    else if (language == "en")
      return Locale("en");
    else
      return Get.deviceLocale;
  }

  void saveLang(String codelang) {
    Locale locale = Locale(codelang);
    AppHelper.saveAppData(key: Const.KEY_LANGUAGE, value: codelang);
    Get.updateLocale(locale);
  }


}
