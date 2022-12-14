import 'package:expectations/controllers/ads_controller.dart';
import 'package:expectations/controllers/expection_controller.dart';
import 'package:expectations/model/match.dart';
import 'package:expectations/model/periodicals.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/ui/match/winners_screen.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShowExpectionScreen extends GetView<ExpectionController> {
  late PeriodicalsData periodicals;
  late Match match;

  var formKey = GlobalKey<FormState>();
  var homeTeamController = TextEditingController();
  var awayTeamController = TextEditingController();

  ShowExpectionScreen({required this.periodicals, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(AppColors.backgroundColor),
      body: Column(
        children: [
          MainToolBar(title: '${periodicals.name}', isBack: false, isProfile: false),
          Expanded(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 16, right: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${Const.baseImagesUrl}${AppHelper.getTeamHomeImage(match)}'))),
                                      ),
                                      Text(
                                        '${match.teamHome!.name}',
                                        style: TextStyle(
                                            color:
                                                HexColor(AppColors.blackColor),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: Const.appFont),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(width: 16),
                                  Container(
                                    width: 40,
                                    height: 20,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFormField(
                                      controller: homeTeamController,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      showCursor: false,
                                      style: TextStyle(
                                          color:
                                              HexColor(AppColors.defualtColor)),
                                      decoration: InputDecoration(
                                        hintText: '_ _',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: HexColor(
                                                AppColors.defualtColor)),
                                      ),
                                      validator: (value) {
                                        if (value!.length <= 3) return null;
                                      },
                                    ),
                                  ),
                                  // SizedBox(width: 16),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(
                                          left: 14, right: 14, bottom: 30),
                                      width: 80,
                                      height: 80,
                                      alignment: Alignment.center,
                                      child: Text(
                                          '${AppHelper.formatMatchTime(match)} PM',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: Const.appFont)),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          border: Border.all(
                                              color: HexColor(
                                                  AppColors.greyColor)))),
                                  // SizedBox(width: 16),
                                  Container(
                                    width: 40,
                                    height: 20,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFormField(
                                      controller: awayTeamController,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      showCursor: false,
                                      style: TextStyle(
                                          color:
                                              HexColor(AppColors.defualtColor)),
                                      decoration: InputDecoration(
                                        hintText: '_ _',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: HexColor(
                                                AppColors.defualtColor)),
                                      ),
                                      validator: (value) {
                                        if (value!.length <= 3) return null;
                                      },
                                    ),
                                  ),
                                  // SizedBox(width: 16),
                                  Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        margin: EdgeInsets.only(
                                            right: 16, left: 28),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${Const.baseImagesUrl}${AppHelper.getTeamAwayImage(match)}'))),
                                      ),
                                      Text(
                                        '${match.teamAway!.name}',
                                        style: TextStyle(
                                            color:
                                                HexColor(AppColors.blackColor),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: Const.appFont),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            'Match info'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: Const.appFont),
                          ),
                          SizedBox(width: 10),
                          Expanded(child: Divider(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 230,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(children: [
                                SvgPicture.asset('assets/icons/match_time.svg',
                                    width: 22, height: 22),
                                SizedBox(width: 10),
                                Text('Match time'.tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                                Spacer(),
                                Text('${match.timing}',
                                    style: TextStyle(
                                        color: HexColor(AppColors.subTextColor),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(children: [
                                SvgPicture.asset('assets/icons/prediction.svg',
                                    width: 22, height: 22),
                                SizedBox(width: 10),
                                Text('League'.tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                                Spacer(),
                                Text('${periodicals.name}',
                                    style: TextStyle(
                                        color: HexColor(AppColors.subTextColor),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(children: [
                                SvgPicture.asset('assets/icons/refree.svg',
                                    width: 22, height: 22),
                                SizedBox(width: 10),
                                Text('${match.judgment}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                                Spacer(),
                                Text('S. Vincic',
                                    style: TextStyle(
                                        color: HexColor(AppColors.subTextColor),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(children: [
                                SvgPicture.asset('assets/icons/stadium.svg',
                                    width: 22, height: 22),
                                SizedBox(width: 10),
                                Text('stadium'.tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                                Spacer(),
                                Text('${match.stadium}',
                                    style: TextStyle(
                                        color: HexColor(AppColors.subTextColor),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: Const.appFont)),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    GetBuilder<AdsController>(
                      builder: (controller) => Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${Const.baseImagesUrl}${controller.listAds[0].image}")),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                              width: 150,
                              height: 48,
                              text: 'Awards'.tr,
                              textColor: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontfamily: Const.appFont,
                              radius: 8,
                              background: HexColor(AppColors.defualtColor),
                              click: () {}),
                          CustomButton(
                              width: 150,
                              height: 48,
                              text: 'winners'.tr,
                              textColor: HexColor(AppColors.defualtColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontfamily: Const.appFont,
                              radius: 8,
                              background: Colors.white,
                              borderColor: AppColors.defualtColor,
                              borderWidth: 1.5,
                              click: () => Get.toNamed(Routes.winners,
                                  arguments:
                                      WinnersScreen(matchId: match.id!))),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
