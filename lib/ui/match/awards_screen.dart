import 'package:expectations/controllers/awards_controller.dart';
import 'package:expectations/model/awards.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AwardsScreen extends GetView<AwardsController> {
  late int matchId;
  List<AwardData> listAwards = [];

  AwardsScreen({required this.matchId});

  @override
  Widget build(BuildContext context) {
    print("length: ${controller.listAwards.length}");
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'Awards', route: Routes.home, isProfile: false),
          !controller.listAwards.isEmpty
              ? Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.listAwards.length,
                      itemBuilder: (context, index) =>
                          buildAwardsItem(controller.listAwards[index])),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      'No prizes yet'.tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: Const.appFont),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

Widget buildAwardsItem(AwardData awards) => Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 65,
              height: 65,
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      '${Const.baseImagesUrl}${AppHelper.formateTeamImage(awards.image!)}')),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(width: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${awards.name!}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: Const.appFont),
                ),
                Text(
                  '${awards.description!}',
                  style: TextStyle(
                      color: HexColor(AppColors.subTextColor),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: Const.appFont),
                ),
              ],
            ),
          ],
        ),
      ),
    );
