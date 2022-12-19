
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

class PrivacyPolicyScreen extends StatefulWidget {


  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  String privacy = '';
  String terms = '';
  String agreement = '';

  @override
  void initState() {
    loadPrivacyPolicyFromAssets();
    loadTermsFromAssets();
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
          MainToolBar(title: 'privacy_policy'.tr, isBack: true, route: Routes.home, isProfile: false),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20, top: 50),
                    child: Text(
                      'privacy_policy'.tr,
                    style: TextStyle(
                      fontFamily: Const.appFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp
                    )),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: 16.r, end: 16.r, top: 16.r),
                    child: Text(
                      '$privacy',
                      maxLines: 200,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: Const.appFont
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20),
                    child: Text(
                        'terms_conditions'.tr,
                        style: TextStyle(
                            fontFamily: Const.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp
                        )),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: 16.r, end: 16.r, top: 16.r),
                    child: Text(
                      '$terms',
                      maxLines: 200,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: Const.appFont
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20),
                    child: Text(
                        'agreement'.tr,
                        style: TextStyle(
                            fontFamily: Const.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp
                        )),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadPrivacyPolicyFromAssets() async {
    try {
      await rootBundle.loadString("assets/Privacy-policy-termify.txt")
      .then((text) {
        if(text != null) {
          setState(() => privacy = text);
          // print('loadFormationFromAssets: $text');
        }
      });
    } catch (e) {
      print("loadFormationFromAssets error: $e");
    }
  }

  Future<void> loadTermsFromAssets() async {
    try {
      await rootBundle.loadString("assets/Terms-of-service-termify.txt")
          .then((text) {
        if(text != null) {
          setState(() => terms = text);
          // print('loadTermsFromAssets: $text');
        }
      });
    } catch (e) {
      print("loadTermsFromAssets error: $e");
    }
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