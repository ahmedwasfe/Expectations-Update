import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/favorite.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxBool isLoading = false.obs;

  List<FavoriteData> listFavorites = [];
  FavoriteData favorite = FavoriteData();

  @override
  void onInit() {
    // fetchFavorites();
    super.onInit();
  }

  Future<void> fetchFavorites() async {
    await ApiRequests.fetchFavorites(token: AppHelper.getCurrentUserToken())
        .then((value) {
          if(value != null){
            listFavorites.clear();
            listFavorites.addAll(value.data!);
            listFavorites.forEach((element) => favorite = element);
            update();
          }
    }).catchError((error) {});
    update();
  }

  void removeFromFavorite(int id) {
    ApiRequests.removeFromFavorite(
            token: AppHelper.getCurrentUserToken(), matchId: id)
        .then((value) {
      fetchFavorites();
      update();
      Get.snackbar('Delete from favourites'.tr, '${value!.data}');
    });
    update();
  }
}
