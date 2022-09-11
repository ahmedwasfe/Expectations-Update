/*
import 'package:expectations/controllers/profile_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreenOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              height: 120,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: HexColor(AppColors.defualtColor),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 20),
                  InkWell(
                      child: SvgPicture.asset('assets/icons/back.svg'),
                      onTap: () => Get.offAndToNamed(Routes.home)),
                  Spacer(),
                  Text(
                    'Profile'.tr,
                    style: TextStyle(
                        color: HexColor(AppColors.whiteColor),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        fontFamily: Const.appFont),
                  ),
                  Spacer(),
                  InkWell(
                      child: SvgPicture.asset('assets/icons/edit_profile.svg'),
                      onTap: () => Get.toNamed(Routes.editProfile)),
                  SizedBox(
                    width: 20,
                  ),
                  // SvgPicture.asset('assets/icons/add_favorit.svg'),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, right: 24),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    'https://i.postimg.cc/B6GcTk8F/default-avatar2.png')),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: HexColor(AppColors.defualtColor))),
                          ),
                          Text(
                            '${profile.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 40),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'full name'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          Text(
                            '${controller.profile.name}',
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 30),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Address'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          Text(
                            '${controller.profile.email}',
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 30),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'phone number'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          Text(
                            '${controller.profile.phone}',
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 30),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          Text(
                            '${controller.profile.address}',
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 30),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'date of birth'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          Text(
                            '${controller.profile.dateOfBirth}',
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 30, bottom: 30),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'athletic inclinations'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                          Text(
                            'Football'.tr,
                            style: TextStyle(
                                color: HexColor(AppColors.subTextColor),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: Const.appFont),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
*/
