import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/favorite_match.dart';
import 'package:expectations/model/match.dart';
import 'package:expectations/model/user_expectations.dart';
import 'package:expectations/ui/match/match_expection_screen.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpectionController extends GetxController {
  ExpectionScreen screen = Get.arguments;

  List<ExpectationData> listExpectations = [];

  late GlobalKey<FormState> formKey;
  late TextEditingController resultHomeController;
  late TextEditingController resultAwayController;

  @override
  void onInit() {
    print('MatchID: ${screen.match.id}');
    formKey = GlobalKey<FormState>();
    resultHomeController = TextEditingController();
    resultAwayController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    formKey.currentState!.dispose();
    resultHomeController.dispose();
    resultAwayController.dispose();
    super.dispose();
  }

  Future<void> fetchExpectations() async {
    await ApiRequests.fetchExpectations(token: AppHelper.getCurrentUserToken())
        .then((value) {
          if(value != null){
            listExpectations.clear();
            listExpectations.addAll(value.data!);
            update();
          }
    });
    update();
  }

  void registerMatchPrediction() {
    int resultHome = int.parse(resultHomeController.text);
    int resultAway = int.parse(resultAwayController.text);
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      ApiRequests.matchPrediction(
              token: AppHelper.getCurrentUserToken(),
              matchId: screen.match.id!,
              resultHome: resultHome,
              resultAway: resultAway)
          .then((value) {
        Get.snackbar('Your prediction has been registered'.tr,
            'تم تسجيل توقعك لمباراة ${screen.match.teamHome!.name!} VS ${screen.match.teamAway!.name!}',
            duration: Duration(seconds: 8)); //need confirm
      });
    }
  }

  Icon checkIsMatchInFavorite(Match match) {
    if (!match.favorites!.isEmpty) {
      for (FavoriteMatch fav in match.favorites!) {
        if (fav.userId == AppHelper.getUserId()) {
          print('CurrentUserID: ${AppHelper.getUserId()}');
          print('UserID: ${fav.userId}');
          // update();
          return Icon(CupertinoIcons.heart_fill, color: Colors.redAccent);
        } else {
          // update();
          return Icon(CupertinoIcons.heart, color: Colors.redAccent);
        }
      }
    } else {
      // update();
      return Icon(CupertinoIcons.heart, color: Colors.redAccent);
    }
    return Icon(CupertinoIcons.heart, color: Colors.redAccent);
  }

  void addRemoveFavorite(Match match) {
    if (!match.favorites!.isEmpty) {
      removeFromFavorite(matchId: match.id!);
      checkIsMatchInFavorite(match);
      // for(FavoriteMatch fav in match.favorites!){
      //   if(fav.userId == AppHelper.getUserId()) {
      //
      //   }else {
      //
      //   }
      // }
    } else {
      addToFavorite(matchId: match.id!);
      checkIsMatchInFavorite(match);
    }
  }

  void addToFavorite({required int matchId}) {
    ApiRequests.addToFavorite(
        token: AppHelper.getCurrentUserToken(), matchId: matchId)
        .then((value) {
      Get.snackbar("add to favourites".tr,
          "The game has been added to the favourites".tr);
    });
  }

  void removeFromFavorite({required int matchId}) {
    ApiRequests.removeFromFavorite(
        token: AppHelper.getCurrentUserToken(), matchId: matchId)
        .then((value) {
      Get.snackbar('Delete from favourites',
          'The match has been removed from the favourites'.tr);
    });
  }
}
