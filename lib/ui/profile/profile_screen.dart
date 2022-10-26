import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/controllers/edit_profile_controller.dart';
import 'package:expectations/controllers/profile_controller.dart';
import 'package:expectations/model/profile.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileController _controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'Profile', isBack: true, route: Routes.home, isProfile: true),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: FutureBuilder(
                future: _controller.fetchUserData(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done)
                    return Column(
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
                                        '${AppHelper.getDefaultImage()}')),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: HexColor(
                                            AppColors.defualtColor))),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                '${_controller.profile.name}',
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
                          margin: EdgeInsetsDirectional.only(start: 20, top: 40),
                          alignment: AlignmentDirectional.centerStart,
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
                                '${_controller.profile.name}',
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
                          margin: EdgeInsetsDirectional.only(start: 20, top: 40),
                          alignment: AlignmentDirectional.centerStart,
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
                                '${_controller.profile.email}',
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
                          margin: EdgeInsetsDirectional.only(start: 20, top: 40),
                          alignment: AlignmentDirectional.centerStart,
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
                                '${_controller.profile.phone}',
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
                          margin: EdgeInsetsDirectional.only(start: 20, top: 40),
                          alignment: AlignmentDirectional.centerStart,
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
                                '${_controller.profile.address}',
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
                          margin: EdgeInsetsDirectional.only(start: 20, top: 40),
                          alignment: AlignmentDirectional.centerStart,
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
                                '${_controller.profile.dateOfBirth}',
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
                          margin: EdgeInsetsDirectional.only(start: 20, top: 40),
                          alignment: AlignmentDirectional.centerStart,
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
                    );
                  else if(snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(top: 28),
                          child: CircularProgressIndicator()),
                    );
                  else
                    return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
