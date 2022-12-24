import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/favorite_match.dart';
import 'package:expectations/model/match.dart';
import 'package:expectations/model/user_expectations.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpectionsPageController extends GetxController {
  List<ExpectationData> listExpectations = [];

  @override
  void onInit() {
    super.onInit();
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
    update();
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
      update();

      Get.snackbar('add to favourites'.tr,
          'The game has been added to the favourites'.tr);
    });
  }

  void removeFromFavorite({required int matchId}) {
    ApiRequests.removeFromFavorite(
            token: AppHelper.getCurrentUserToken(), matchId: matchId)
        .then((value) {
      update();
      Get.snackbar('Delete from favourites'.tr,
          'The match has been removed from the favourites'.tr);
    });
  }
}
