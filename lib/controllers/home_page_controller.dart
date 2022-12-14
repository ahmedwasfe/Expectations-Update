import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/days.dart';
import 'package:expectations/model/favorite_match.dart';
import 'package:expectations/model/home_matches/home_matches.dart';
import 'package:expectations/model/match.dart';
import 'package:expectations/model/periodicals.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  RxBool isLoading = false.obs;


  List<PeriodicalsData> listPeriodicals = [];
  List<HomeMatchesData> listHomeMatches = [];
  List<FavoriteMatch> listFavorite = [];
  List<Days> listDays = [];

  PeriodicalsData periodicalsData = PeriodicalsData();
  Match match = Match();

  Icon icon = Icon(CupertinoIcons.heart);

  @override
  void onInit() {
    getDates();
    // fetchPeriodicals();
    fetchHomeMatches();
    super.onInit();
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

  void getDates() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final aftarTomorrow = DateTime(now.year, now.month, now.day + 2);

    final dateToday =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final dateTomorrow =
        '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
    final dateAftarTomorrow =
        '${aftarTomorrow.year}-${aftarTomorrow.month.toString().padLeft(2, '0')}-${aftarTomorrow.day.toString().padLeft(2, '0')}';

    print('Today: $dateToday');
    print('tomorrow: $dateTomorrow');
    print('aftarTomorrow: $dateAftarTomorrow');

    listDays = [
      Days(day: 'All matches'.tr, date: ''),
      Days(day: 'today'.tr, date: '$dateToday'),
      Days(day: '??????', date: '$dateTomorrow'),
      Days(day: 'tomorrow'.tr, date: '$dateAftarTomorrow'),
      Days(day: 'any day'.tr, date: '2022-12-15'),
    ];
  }

  void fetchHomeMatches() {
    isLoading(true);
    ApiRequests.fetchHomeMatches(
        from: '${AppHelper.getDateTody()}',
        to: '${AppHelper.getDateTody()}')
        .then((value) {
      if (value != null) {
        listHomeMatches.clear();
        listHomeMatches.addAll(value.data!);
        isLoading(false);
        update();
      } else
        isLoading(false);
    }).catchError((error) => isLoading(false));
    update();
  }

  void fetchPeriodicals() {
    isLoading(true);
    if (AppHelper.getCurrentUserToken() != null) {
      // print(AppHelper.getCurrentUserToken());
      ApiRequests.fetchPeriodicals(token: AppHelper.getCurrentUserToken())
          .then((value) {
        if (value != null) {
          listPeriodicals.clear();
          listPeriodicals.addAll(value.data!);
          isLoading(false);
          update();
        } else
          isLoading(false);
        update();
        // print('fetchPeriodicals ${listPeriodicals.length}');
        // print('fetchPeriodicals: ${jsonEncode(listPeriodicals)}');
      }).catchError((error) => isLoading(false));
    }
    update();
  }

  void fetchPeriodicalsByDate({required String date}) {
    if (AppHelper.getCurrentUserToken() != null) {
      isLoading(true);
      ApiRequests.fetchPeriodicalsByDate(
              token: AppHelper.getCurrentUserToken(), date: date)
          .then((value) {
        listPeriodicals.clear();
        listPeriodicals.addAll(value!.data!);
        isLoading(false);
        update();
      }).catchError((error) => isLoading(false));
    }
    update();
  }

  String checkPeriodicalsCount(int? matchsCount) {
    print('COUNT: $matchsCount');
    if (matchsCount != null) {
      if (matchsCount == 1)
        return 'match'.tr;
      else if (matchsCount == 2)
        return 'two games'.tr;
      else if (matchsCount >= 3 && matchsCount <= 10)
        return '$matchsCount ?????????????? '; //need confirm
      else
        return '$matchsCount ???????????? '; //need confirm
    }
    update();
    return '';
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
