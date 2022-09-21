import 'package:expectations/controllers/boarding_controller.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';

class StartedScreen extends GetView<BoardingsController> {

  BoardingsController _controller = Get.put(BoardingsController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
      body: FutureBuilder(
        future: _controller.fetchBoardings(),
        builder: (context, snapshot) =>  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo4.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                AppHelper.getAppLanguage() == "ar" ? '${controller.listBoardings[3].title}' : '${controller.listBoardings[7].title}',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: '${Const.appFont}'),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                    AppHelper.getAppLanguage() == "ar" ? '${controller.listBoardings[3].description}' : '${controller.listBoardings[7].description}',
                    style: TextStyle(
                      color: HexColor(AppColors.subTextColor),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: '${Const.appFont}',
                    ),
                    textAlign: TextAlign.center),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 30, right: 30),
                child: CustomButton(
                    text: 'start now'.tr,
                    textColor: HexColor(AppColors.whiteColor),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontfamily: '${Const.appFont}',
                    radius: 8,
                    background: HexColor(AppColors.defualtColor),
                    click: () => Get.toNamed('/register')),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Do you have an account?'.tr,
                      style: TextStyle(
                          color: HexColor(AppColors.subTextColor),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: Const.appFont),
                    ),
                    InkWell(
                      child: Text(
                        'Login'.tr,
                        style: TextStyle(
                            color: HexColor(AppColors.blackColor),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: Const.appFont),
                      ),
                      onTap: () => Get.toNamed('/login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
