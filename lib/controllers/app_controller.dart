import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/live/all_live.dart';
import 'package:get/get.dart';

class AppController extends GetxController{

List<LiveData> listLive = [];

  Future<void> fetchAllLive() async {
    await ApiRequests.getAllLive()
        .then((value) {
          if(value != null) {
            listLive.addAll(value.data!);
            // print('SIZE: ${listLive.length}');
            // print('LIVES: ${jsonEncode(listLive)}');
          }

    });
  }

}