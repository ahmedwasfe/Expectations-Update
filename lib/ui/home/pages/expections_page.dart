
import 'package:expectations/controllers/expections_page_controller.dart';
import 'package:expectations/model/user_expectations.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';


class ExpectionsPage extends StatelessWidget {

  final ExpectionsPageController _controller = Get.put(ExpectionsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'My Expectations', isBack: false, isProfile: false),
          Expanded(
            child: FutureBuilder(
              future: _controller.fetchExpectations(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(_controller.listExpectations.isNotEmpty){
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _controller.listExpectations.length,
                        itemBuilder: (context, index) => buildExpectionsItem(index, expectation: _controller.listExpectations[index]));
                  }else{
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (context, index) => buildExpectionsItem(index));
                  }
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return CustomProgress();
                }else{
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpectionsItem(int index, {ExpectationData? expectation}) => Container(
        width: double.infinity,
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: GetBuilder<ExpectionsPageController>(builder: (controller) => IconButton(
                    icon: expectation != null ? _controller.checkIsMatchInFavorite(expectation.match!) : index % 2 == 0 ? Icon(CupertinoIcons.heart_fill, color: Colors.redAccent) : Icon(CupertinoIcons.heart, color: Colors.redAccent),
                    onPressed: () {
                      if(expectation != null)
                        _controller.addRemoveFavorite(expectation.match!);
                    })),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        expectation != null ? '${Const.baseImagesUrl}${AppHelper.getTeamHomeImage(expectation.match!)}' : '${Const.logoDefaultImage}'))),
                          ),
                          Text(
                            expectation != null ? '${expectation.match!.teamHome!.name!}' : 'Tawaq3',
                            style: TextStyle(
                                color: HexColor(AppColors.blackColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                      // SizedBox(width: 16),
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        child: Text(
                          expectation != null ? '${expectation.result1!}' : '0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor(AppColors.defualtColor),
                            ),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      // SizedBox(width: 16),
                      Container(
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              child: Text('not started'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: HexColor(AppColors.subTextColor),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: Const.appFont)),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: HexColor(AppColors.greyColor2)),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            Text(
                               expectation != null ? '${AppHelper.formatMatchTime(expectation.match!)}' : '10:00 PM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: HexColor(AppColors.defualtColor),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Const.appFont)),
                            Text(
                                expectation != null ? '${AppHelper.formatMatchDate(expectation.match!)}' : '20-05-2022',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: HexColor(AppColors.subTextColor),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Const.appFont)),
                          ],
                        ),
                      ),
                      // SizedBox(width: 16),
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          expectation != null ? '${expectation.result2!}' : '0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor(AppColors.defualtColor),
                            ),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      // SizedBox(width: 16),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(right: 16, left: 28),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                       expectation != null ? '${Const.baseImagesUrl}${AppHelper.getTeamAwayImage(expectation.match!)}' : '${Const.logoDefaultImage}'))),
                          ),
                          Text(
                            expectation != null ? '${expectation.match!.teamAway!.name!}' : 'Tawaq3',
                            style: TextStyle(
                                color: HexColor(AppColors.blackColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
