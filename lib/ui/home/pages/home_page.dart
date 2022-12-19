import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:expectations/api/api_requests.dart';
import 'package:expectations/controllers/ads_controller.dart';
import 'package:expectations/controllers/home_controller.dart';
import 'package:expectations/controllers/home_page_controller.dart';
import 'package:expectations/model/ads.dart';
import 'package:expectations/model/days.dart';
import 'package:expectations/model/home_matches/home_matches.dart';
import 'package:expectations/model/periodicals.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/ui/home/show_periodicals.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdsController _adsController = Get.put(AdsController());
  HomePageController homeController = Get.put(HomePageController());

  bool isLoading = false;
  List<Days> listDays = [];
  List<AdsData> listAds = [];
  List<PeriodicalsData> listPeriodicals = [];
  List<HomeMatchesData> listHomeMatches = [];

  late String dateToday = '';

  @override
  initState() {
    getDates();
    // fetchPeriodicals();
    super.initState();
    setState(() => fetchHomeMatches());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
                color: HexColor(AppColors.defualtColor),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10).r,
                    bottomRight: Radius.circular(10).r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 20.w),
                InkWell(
                  child: SvgPicture.asset(
                    'assets/icons/live.svg',
                    height: 28.h,
                    width: 28.w,
                  ),
                  onTap: () {
                    if(AppHelper.getUserToken(key: Const.KEY_USER_TOKEN) == null)
                      AppHelper.showLoginDialog(context);
                    else
                      Get.toNamed(Routes.allLive);
                  },
                ),
                Spacer(),
                Text(
                  "Main".tr,
                  style: TextStyle(
                      color: HexColor(AppColors.whiteColor),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: Const.appFont),
                ),
                SizedBox(width: 70.w),
                InkWell(
                    child: SvgPicture.asset('assets/icons/search.svg',
                        height: 20.h, width: 20.w),
                    onTap: () {
                      if(AppHelper.getUserToken(key: Const.KEY_USER_TOKEN) == null)
                        AppHelper.showLoginDialog(context);
                      else
                        Get.toNamed(Routes.search);
                    } ),
                SizedBox(
                  width: 20.w,
                ),
                GetBuilder<HomeController>(
                    builder: (home) => InkWell(
                          child: SvgPicture.asset('assets/icons/menu.svg'),
                          onTap: () {
                            if(AppHelper.getUserToken(key: Const.KEY_USER_TOKEN) == null)
                              AppHelper.showLoginDialog(context);
                            else
                              home.getCurrenNavIndex(navIndex: 4);
                          },
                        )),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  FutureBuilder(
                    future: fetchAds(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.done) if (listAds.isNotEmpty)
                        return ImageSlideshow(
                          width: double.infinity,
                          height: 200.h,
                          initialPage: 0,
                          autoPlayInterval: 3000,
                          isLoop: true,
                          indicatorColor: Colors.transparent,
                          indicatorBackgroundColor: Colors.transparent,
                          children: listAds
                              .map((element) => Container(
                                    margin: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${Const.baseImagesUrl}${element.image}'),
                                            fit: BoxFit.contain),
                                        borderRadius:
                                            BorderRadius.circular(10).r),
                                  ))
                              .toList(),
                        );
                      else
                        return Container(
                          width: double.infinity,
                          height: 250.h,
                        );
                      else
                        return Container(
                          width: double.infinity,
                          height: 250.h,
                        );
                    },
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: listDays.map(
                            (day) {
                              return InkWell(
                                child: Container(
                                  margin: EdgeInsets.all(10).r,
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle(
                                        color: HexColor(AppColors.blackColor),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: Const.appFont),
                                  ),
                                ),
                                onTap: () {
                                  if (day.day == 'مباريات' || day.day == 'Matches') {
                                    // need
                                    print("ALL: ${day.date}");
                                    fetchHomeMatches();
                                  } else {
                                    print("DATE: ${day.date}");
                                    fetchHomeMatchesByDate(date: '${day.date}');
                                    // fetchPeriodicalsByDate(date: '${day.date}');
                                  }
                                },
                              );
                            },
                          ).toList())),
                  SizedBox(height: 4.h),
                  isLoading == true
                      ? CustomProgress()
                      : Container(),
                  SizedBox(height: 16.h),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: listHomeMatches.length,
                    itemBuilder: (context, index) =>
                        MatchHomeItem(match: listHomeMatches[index]),
                    // listHomeMatches.isEmpty
                    //     ? Container()
                    //     : /*buildItem(listPeriodicals[index])*/ Text('test'),
                  ),
                  // ExpandableTheme(
                  //     data: ExpandableThemeData(useInkWell: true),
                  //     child: ListView.builder(
                  //       primary: false,
                  //       shrinkWrap: true,
                  //       itemCount: listPeriodicals.length,
                  //       itemBuilder: (context, index) =>
                  //           listPeriodicals[index].matches!.isEmpty
                  //               ? Container()
                  //               : buildItem(listPeriodicals[index]),
                  //     )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(PeriodicalsData periodicals) => ExpandableNotifier(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          color: HexColor(AppColors.defualtColor),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: Container(
                  color: HexColor(AppColors.defualtColor),
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      // tapBodyToCollapse: true,
                      iconColor: Colors.white,
                      expandIcon: Icons.arrow_drop_up,
                      collapseIcon: Icons.arrow_drop_down,
                      iconSize: 40,
                    ),
                    header: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: HexColor(AppColors.defualtColor),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 6),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: periodicals.image != null
                                      ? NetworkImage(
                                          '${Const.baseImagesUrl}${periodicals.image}')
                                      : NetworkImage(
                                          'https://i.postimg.cc/s2WwRQW8/playstore.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            AppHelper.getAppLanguage() == 'ar'
                                ? '${periodicals.name}'
                                : '${periodicals.nameEn}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          Spacer(),
                          Text(
                            '${checkPeriodicalsCount(periodicals.matches!.length)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: Const.appFont),
                          )
                        ],
                      ),
                    ),
                    collapsed: Container(),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: periodicals.matches!.map((match) {
                        if (match != null)
                          return MatchItem(
                              periodicals: periodicals, match: match);
                        else
                          return Container();
                      }).toList(),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

  String checkPeriodicalsCount(int? matchsCount) {
    print('COUNT: $matchsCount');
    if (matchsCount != null) {
      if (matchsCount == 1)
        return 'match'.tr; //new confirm
      else if (matchsCount == 2)
        return 'two games'.tr; //need confirm
      else if (matchsCount >= 3 && matchsCount <= 10)
        return "$matchsCount" + "matches".tr; //need confirm
      else
        return "$matchsCount" + "match".tr; // need confirm
    }
    return '';
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

    // print('Today: $dateToday');
    // print('tomorrow: $dateTomorrow');
    // print('aftarTomorrow: $dateAftarTomorrow');

    listDays = [
      Days(day: 'matches'.tr, date: ''),
      Days(day: 'today'.tr, date: '$dateToday'),
      Days(day: 'tomorrow'.tr, date: '$dateTomorrow'),
      Days(day: 'The Day After Tomorrow'.tr, date: '$dateAftarTomorrow'),
      // Days(day: 'أي يوم', date: '2022-12-15'),
    ];
  }

  Future<void> fetchAds() async {
    await ApiRequests.fetchAds().then((value) => listAds.addAll(value!.data!));
  }

  void fetchPeriodicals() {
    setState(() => isLoading = true);
    if (AppHelper.getCurrentUserToken() != null) {
      // print(AppHelper.getCurrentUserToken());
      ApiRequests.fetchPeriodicals(token: AppHelper.getCurrentUserToken())
          .then((value) {
        if (value != null) {
          setState(() {
            listPeriodicals.clear();
            listPeriodicals.addAll(value.data!);
            isLoading = false;
          });
        } else
          setState(() => isLoading = false);
      }).catchError((error) => setState(() => isLoading = false));
    }
  }

  void fetchHomeMatches() {
    setState(() => isLoading = true);
    ApiRequests.fetchHomeMatches(
            from: '${AppHelper.getDateTody()}',
            to: '${AppHelper.getDateTody()}')
        .then((value) {
      if (value != null) {
        listHomeMatches.clear();
        listHomeMatches.addAll(value.data!);
        // print('SIZE: ${listHomeMatches.length}');
        // print('HomeMatches: ${jsonEncode(listHomeMatches)}');
        setState(() => isLoading = false);
      } else
        setState(() => isLoading = false);
    }).catchError((error) => setState(() => isLoading = false));
  }

  void fetchHomeMatchesByDate({required String date}) {
    setState(() => isLoading = true);
    ApiRequests.fetchHomeMatches(
        from: '$date',
        to: '$date')
        .then((value) {
      if (value != null) {
        listHomeMatches.clear();
        listHomeMatches.addAll(value.data!);
        print('SIZE: ${listHomeMatches.length}');
        print('HomeMatches: ${jsonEncode(listHomeMatches)}');
        setState(() => isLoading = false);
      } else
        setState(() => isLoading = false);
    }).catchError((error) => setState(() => isLoading = false));
  }

  void fetchPeriodicalsByDate({required String date}) {
    if (AppHelper.getCurrentUserToken() != null) {
      setState(() => isLoading = true);
      ApiRequests.fetchPeriodicalsByDate(
              token: AppHelper.getCurrentUserToken(), date: date)
          .then((value) {
        setState(() {
          listPeriodicals.clear();
          listPeriodicals.addAll(value!.data!);
          isLoading = false;
        });
      }).catchError((error) => setState(() => isLoading = false));
    }
  }
}
