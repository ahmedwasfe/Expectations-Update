import 'package:expectations/controllers/boarding_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends GetView<BoardingsController> {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'About Us', isBack: true, route: Routes.home),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/logo41.png'),
                            fit: BoxFit.contain),
                        ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 20),
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.listBoardings[4].title}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont),
                        ),
                        Text(
                          '${controller.listBoardings[4].description}',
                          style: TextStyle(
                              color: HexColor(AppColors.subTextColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: Const.appFont),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 20),
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.listBoardings[5].title}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont),
                        ),
                        Text(
                          '${controller.listBoardings[5].description}',
                          style: TextStyle(
                              color: HexColor(AppColors.subTextColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: Const.appFont),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 20),
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.listBoardings[6].title}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont),
                        ),
                        Text(
                          '${controller.listBoardings[6].description}',
                          style: TextStyle(
                              color: HexColor(AppColors.subTextColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: Const.appFont),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 20),
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.listBoardings[7].title}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont),
                        ),
                        Text(
                          '${controller.listBoardings[7].description}',
                          style: TextStyle(
                              color: HexColor(AppColors.subTextColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: Const.appFont),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'note'.tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont),
                        ),
                        Text(
                          "This app was made in partnership with Hedge Technologies"
                              .tr,
                          style: TextStyle(
                              color: HexColor(AppColors.subTextColor),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: Const.appFont),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Text('https://hedgetech.sa/ar/'),
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor(AppColors.subTextColor)),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 10, top: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/contact.svg',
                            width: 16, height: 16),
                        SizedBox(width: 16),
                        Text(
                          'tawaqwat2022@gmail.com',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 10, top: 20, bottom: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/locations.svg',
                            width: 20, height: 20),
                        SizedBox(width: 16),
                        Text(
                          'Saudi - Jeddah'.tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: Const.appFont),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20, bottom: 50),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: SvgPicture.asset('assets/icons/facebook.svg',
                              height: 30, width: 30),
                          onTap: () => launchUrl(Uri.parse('https://www.facebook.com')),
                        ),
                        InkWell(
                          child: SvgPicture.asset('assets/icons/twitter.svg',
                              height: 30, width: 30),
                          onTap: () => launchUrl(Uri.parse('https://www.twitter.com')),
                        ),
                        InkWell(
                          child: SvgPicture.asset('assets/icons/linkedin.svg',
                              height: 34, width: 34),
                          onTap: () => launchUrl(Uri.parse('https://www.linkedin.com')),
                        ),
                        InkWell(
                          child: SvgPicture.asset('assets/icons/whatsapp.svg',
                              height: 38, width: 38),
                          onTap: () => launchUrl(Uri.parse('https://www.whatsapp.com')),
                        ),
                        InkWell(
                          child: SvgPicture.asset('assets/icons/instagram.svg',
                              height: 30, width: 30),
                          onTap: () => launchUrl(Uri.parse('https://www.instagram.com')),
                        ),
                        InkWell(
                          child: SvgPicture.asset('assets/icons/snapchat.svg',
                              height: 30, width: 30),
                          onTap: () => launchUrl(Uri.parse('https://www.snapchat.com')),
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
  }
}
