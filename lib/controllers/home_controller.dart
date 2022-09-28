import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/controllers/live_controller.dart';
import 'package:expectations/model/ads.dart';
import 'package:expectations/model/match.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/ui/live/live_screen.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  LiveController _liveController = Get.put(LiveController());

  var navIndex = 0;

  void getCurrenNavIndex({required int navIndex, BuildContext? context}) async {
    if (navIndex == 2) {
      if(AppHelper.getUserToken(key: Const.KEY_USER_TOKEN) == null)
        AppHelper.showLoginDialog(context!);
      else{
        await joinLive(context!,
            isBroadcaster: true, userType: Const.KEY_BROADCASTER);
      }

      update();
    } else {
      if(AppHelper.getUserToken(key: Const.KEY_USER_TOKEN) == null)
        AppHelper.showLoginDialog(context!);
      else
        this.navIndex = navIndex;
      update();
    }
  }

  Future<void> joinLive(BuildContext context,
      {bool? isBroadcaster, String? userType}) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      // _liveController.createNewLive();
      // requestMultiplePermissions;
      return LiveScreen(
        isBroadcaster: isBroadcaster!,
        userType: userType!,
      );
    }));
    if (userType == Const.KEY_BROADCASTER) _liveController.createNewLive();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
