import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/live/agora_token.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  bool? boarding = AppHelper.getAppData(key: Const.KEY_BOARDING);

  @override
  void onInit() {
    getFirebaseToken();
    getAgoraToken();
    startApp();
    super.onInit();
  }

  Future startApp() {
    // Future.delayed(Duration(seconds: 8), () => Get.offAndToNamed('/boarding'));
    if (boarding != null) {
      if (AppHelper.getUserToken(key: Const.KEY_USER_TOKEN) != null)
        return Future.delayed(
            Duration(seconds: 5), () {
              if(AppHelper.getExpiredDate() != null && AppHelper.getExpiredDate() != ""){
                if(AppHelper.getDateTody() == AppHelper.getExpiredDate())
                  Get.offAndToNamed(Routes.packages);
                else
                  Get.offAndToNamed(Routes.home);
              }else
                Get.offAndToNamed(Routes.home);
          print('Expired: ${AppHelper.getExpiredDate()}');
          print('TODAY: ${AppHelper.getDateTody()}');
        });
      else
        return Future.delayed(
            Duration(seconds: 5), () => Get.offAndToNamed(Routes.started));
    } else
      return Future.delayed(
          Duration(seconds: 5),
          () => Get.offAndToNamed(
              Routes.language)); // i change .boarding to language
  }

  void getFirebaseToken() {
    FirebaseMessaging.instance.getToken().then((newToken) {
      // print("FirebaseToken: $newToken");
      AppHelper.saveUserToken(key: Const.KEY_FIREBASE_TOKEN, token: newToken!);
    });
    update();
  }

  void getAgoraToken(){
    ApiRequests.getAgorToken()
        .then((value) {
       if(value != null){
         AgoraToken token = AgoraToken();
         token = value;
         AppHelper.saveLiveToken(key: Const.KEY_AGORA_TOKEN, token: token.token!);
         AppHelper.saveChannelName(key: Const.KEY_CHANNEL_NAME, channel: token.channelName!);
       }
    });
  }


}
