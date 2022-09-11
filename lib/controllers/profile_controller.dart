import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/profile.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  ProfileData profile = ProfileData();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserData() async {
    await ApiRequests.fetchUserData(token: AppHelper.getCurrentUserToken())
        .then((value) {
      profile = value!.data!;
    });
  }
}
