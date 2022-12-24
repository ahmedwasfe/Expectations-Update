
import 'dart:convert';

import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPolicyScreen extends StatefulWidget {


  @override
  State<UserPolicyScreen> createState() => _UserPolicyScreenState();
}

class _UserPolicyScreenState extends State<UserPolicyScreen> {

  String agreement = '';

  @override
  void initState() {
    loadLicenseAgreementFromAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // loadFormationFromAssets();
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          MainToolBar(title: 'agreement'.tr, isBack: true, route: Routes.home, isProfile: false),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20.r, top: 50.r),
                    child: InkWell(
                      child: Text(
                          'agreement'.tr,
                          style: TextStyle(
                              fontFamily: Const.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                            color: Colors.blueAccent
                          )),
                      onTap: () => launchUrl(Uri.parse('https://tawaq3.com/en/end-user-license-agreement/')),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: 16.r, end: 16.r, top: 16.r),
                    child: Text(
                      '$agreement',
                      maxLines: 200,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Const.appFont
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20.r, top: 20.r, bottom: 20.r),
                    child: InkWell(
                      child: Text(
                          'read_agreement'.tr,
                          style: TextStyle(
                              fontFamily: Const.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: Colors.blueAccent
                          )),
                      onTap: () => launchUrl(Uri.parse('https://tawaq3.com/en/end-user-license-agreement/')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> loadLicenseAgreementFromAssets() async {
    try {
      await rootBundle.loadString("assets/eula-termify.txt")
          .then((text) {
        if(text != null) {
          setState(() => agreement = text);
          print('loadLicenseAgreementFromAssets: $text');
        }
      });
    } catch (e) {
      print("loadLicenseAgreementFromAssets error: $e");
    }
  }

}