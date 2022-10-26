import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/notifications.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController{

  List<NotificationData> listNotifications = [];

  @override
  void onInit(){
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    await ApiRequests.fetchNotifications().then((value) {
      listNotifications.clear();
      // listNotifications.addAll(value!.data!);
    });
  }
}