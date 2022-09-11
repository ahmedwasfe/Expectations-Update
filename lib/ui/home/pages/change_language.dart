import 'package:expectations/controllers/language_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/style/colors.dart';

class ChangeLanguagee extends StatefulWidget {
  const ChangeLanguagee({Key? key}) : super(key: key);

  @override
  _ChangeLanguageeState createState() => _ChangeLanguageeState();
}

class _ChangeLanguageeState extends State<ChangeLanguagee> {
  bool status = true;
  bool status2 = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: size.height / 6, bottom: size.height / 9),
            child: Center(
              child: Image.asset(
                'assets/icons/logo3.png',
                height: size.height / 4,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height / 30),
            child: Text(
              "اختر لغتك المفضلة",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontFamily: Const.appFont),
            ),
          ),
          GetBuilder<LanguageController>(
            builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      status = true;
                      status2 = false;
                    });
                    controller.saveLang("en");
                    Get.toNamed(Routes.boarding);
                  },
                  child: Container(
                    width: size.width / 2.8,
                    height: size.height / 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: status
                            ? Colors.white
                            : HexColor(AppColors.defualtColor),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: status
                          ? HexColor(AppColors.defualtColor)
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "English",
                        style: TextStyle(
                            color: status
                                ? Colors.white
                                : HexColor(AppColors.defualtColor),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            fontFamily: Const.appFont),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      status = false;
                      status2 = true;
                    });
                    controller.saveLang("ar");
                    Get.toNamed(Routes.boarding);
                  },
                  child: Container(
                    width: size.width / 2.8,
                    height: size.height / 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: status2
                            ? Colors.white
                            : HexColor(AppColors.defualtColor),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: status2
                          ? HexColor(AppColors.defualtColor)
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "العربية",
                        style: TextStyle(
                            color: status2
                                ? Colors.white
                                : HexColor(AppColors.defualtColor),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            fontFamily: Const.appFont),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
