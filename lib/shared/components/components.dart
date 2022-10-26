import 'package:expectations/controllers/language_controller.dart';
import 'package:expectations/model/boarding.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget CustomButton({
  required String text,
  required Function() click,
  double width = double.infinity,
  double height = 48.0,
  Color background = Colors.redAccent,
  bool isUpperCase = true,
  Color textColor = Colors.white,
  double fontSize = 16.0,
  String fontfamily = "",
  FontWeight fontWeight = FontWeight.w700,
  double radius = 0.0,
  double marginLeft = 0.0,
  String borderColor = AppColors.defualtColor,
  double borderWidth = 1.5,
}) =>
    Container(
      margin: EdgeInsets.only(left: marginLeft),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: click,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: fontfamily,
              fontWeight: fontWeight),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
        border: Border.all(color: HexColor(borderColor), width: borderWidth)
      ),
    );

Widget PageViewScreens(BoardingData boarding, List<BoardingData> listBoardings, int index) {
  if(index == 0)
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Image.asset('assets/images/boarding${boarding.id}.png', fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280.0).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppHelper.getAppLanguage() == "ar" ? '${listBoardings[0].title}' : '${listBoardings[4].title}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: '${Const.appFont}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12).r,
                  child: Text(
                    AppHelper.getAppLanguage() == "ar" ? '${listBoardings[0].description}' : '${listBoardings[4].description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: '${Const.appFont}',
                    ),
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  else if(index == 1)
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Image.asset('assets/images/boarding${boarding.id}.png', fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280.0).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppHelper.getAppLanguage() == "ar" ? '${listBoardings[1].title}' : '${listBoardings[5].title}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: '${Const.appFont}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12).r,
                  child: Text(
                    AppHelper.getAppLanguage() == "ar" ? '${listBoardings[1].description}' : '${listBoardings[5].description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: '${Const.appFont}',
                    ),
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  else if(index == 2)
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Image.asset('assets/images/boarding${boarding.id}.png', fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280.0).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppHelper.getAppLanguage() == "ar" ? '${listBoardings[2].title}' : '${listBoardings[6].title}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: '${Const.appFont}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12).r,
                  child: Text(
                    AppHelper.getAppLanguage() == "ar" ? '${listBoardings[2].description}' : '${listBoardings[6].description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: '${Const.appFont}',
                    ),
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  else
    return Container();
}


class MainToolBar extends StatelessWidget {

  String? title;
  String? route = '';
  bool? isBack = false;

  MainToolBar({required this.title, this.route, this.isBack});

  Widget AppTooBar() => AppBar(
    backgroundColor: HexColor(AppColors.defualtColor),
    toolbarHeight: 60.h,
    title: Text(
      '$title'.tr,
      style: TextStyle(
          color: HexColor(AppColors.whiteColor),
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontFamily: Const.appFont
      ),
      textAlign: TextAlign.center,),
    centerTitle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(11.0),
          bottomLeft: Radius.circular(11.0)),
    ),
    leading: isBack! ? InkWell(
        child: AppHelper.getAppLanguage() == 'ar' ? Image.asset('assets/icons/back.png') : Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onTap: () => Get.offAndToNamed(route!)) : Container(),
  );

  @override
  Widget build(BuildContext context) {
    print('LANG: ${AppHelper.getAppLanguage()}');
    return AppTooBar();
     /*
      Container(
      height: 60,
      decoration: BoxDecoration(
          color: HexColor(AppColors.defualtColor),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            SizedBox(width: 20),
            isBack! ? InkWell(
                child: SvgPicture.asset('assets/icons/back.svg'),
                onTap: () => Get.offAndToNamed(route!)) : Container(),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                '$title'.tr,
                style: TextStyle(
                    color: HexColor(AppColors.whiteColor),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: Const.appFont),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}

