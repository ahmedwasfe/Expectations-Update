import 'dart:io';

import 'package:expectations/api/purchases_api.dart';
import 'package:expectations/controllers/register_controller.dart';
import 'package:expectations/model/Packages/packages.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/ui/auth/apple_pay_screen.dart';
import 'package:expectations/ui/widget/pay_wall_widget.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  RegisterController _controller = Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
    Purchases.addCustomerInfoUpdateListener(
        (customerInfo) => updateCustomerStatus());
    updateCustomerStatus();
  }

  Future updateCustomerStatus() async {
    final customerInfo = await Purchases.getCustomerInfo();
    customerInfo.entitlements.active['Write here entitlements identifier'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(
              title: 'packages',
              isBack: true,
              route: Routes.home,
              isProfile: false),
          FutureBuilder(
            future: Platform.isAndroid
                ? _controller.getPackages()
                : _controller.fetchOffers(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Platform.isAndroid
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: _controller.listPackages.length,
                            itemBuilder: (context, index) => buildPackageItem(
                                _controller.listPackages[index])))
                    : Expanded(
                      child: Center(
                          child: Container(
                            margin: EdgeInsetsDirectional.only(start: 20.r, end: 20.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                    text: 'subscription_product'.tr,
                                    isUpperCase: false,
                                    radius: 8,
                                    background: HexColor(AppColors.defualtColor),
                                    click: () => showSubscriptionBottomSheet(context, buildApplePay())),
                                SizedBox(height: 20.r),
                                CustomButton(
                                    text: 'subscription_package'.tr,
                                    isUpperCase: false,
                                    radius: 8,
                                    background: HexColor(AppColors.defualtColor),
                                    click: () => showSubscriptionBottomSheet(context, PayWallWidget(
                                        title: '',
                                        description: '',
                                        packages: _controller.packages,
                                        onCLickPackage: (package) =>
                                            PurchasesApi.purchaesPackage(package)))),
                              ],
                            ),
                          ),
                        ),
                    );
              else if (snapshot.connectionState == ConnectionState.waiting)
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              else
                return Container();
            },
          )
        ],
      ),
    );
  }

  // Widget buildPackageItem(PackagesData package) => Container(
  //       width: double.infinity,
  //       height: 250.h,
  //       margin: EdgeInsets.all(10.r),
  //       child: Card(
  //         color: HexColor(AppColors.dotColor),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
  //         child: Column(
  //           children: [
  //             Container(
  //               width: 50,
  //               height: 50,
  //               margin: EdgeInsets.only(top: 10.r, bottom: 10.r),
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(100.r),
  //                   image: DecorationImage(
  //                       image: NetworkImage(
  //                           '${AppHelper.getUrlImage()}${package.image}'),
  //                       fit: BoxFit.cover)),
  //             ),
  //             Text(
  //                 AppHelper.getAppLanguage() == 'ar'
  //                     ? '${package.titleAr}'
  //                     : '${package.titleEn}',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontFamily: Const.appFont,
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w800)),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text('price'.tr,
  //                     style: TextStyle(
  //                         color: Colors.white,
  //                         fontFamily: Const.appFont,
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.w600)),
  //                 SizedBox(width: 10.w),
  //                 Text('${package.price}',
  //                     style: TextStyle(
  //                         color: Colors.white,
  //                         fontFamily: Const.appFont,
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.w600)),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text('days'.tr,
  //                     style: TextStyle(
  //                         color: Colors.white,
  //                         fontFamily: Const.appFont,
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w600)),
  //                 SizedBox(width: 10.w),
  //                 Text('${package.days}',
  //                     style: TextStyle(
  //                         color: Colors.white,
  //                         fontFamily: Const.appFont,
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w600)),
  //               ],
  //             ),
  //             Spacer(),
  //             CustomButton(
  //                 text: 'enroll'.tr,
  //                 width: 200.w,
  //                 radius: 8.r,
  //                 background: HexColor(AppColors.defualtColor),
  //                 borderColor: AppColors.defualtColor,
  //                 click: () async {
  //                   _controller.purchaesPackage(Package());
  //                  //  // Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePayScreen(package: package)));
  //                  // if(Platform.isIOS){
  //                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePayScreen(package: package)));
  //                  // }else{
  //                  //   _controller.payNow(package.price!.toDouble());
  //                  // }
  //                 }),
  //             SizedBox(height: 16.h),
  //           ],
  //         ),
  //       ),
  //     );

  Widget buildApplePay() => Center(
        child: Container(
          height: 100.w,
          margin: EdgeInsetsDirectional.only(start: 20.r, end: 20.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.paid, color: HexColor(AppColors.defualtColor)),
              const SizedBox(height: 20),
              CustomButton(
                  text: 'buy_subscription'.tr,
                  isUpperCase: false,
                  radius: 8,
                  background: HexColor(AppColors.defualtColor),
                  click: () async {
                    await PurchasesApi.purchaesProduct('Write here plan id');
                  }),
            ],
          ),
        ),
      );

  void showSubscriptionBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 320,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 50,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(height: 20),
                Text(''),
                SizedBox(height: 14),
                SizedBox(height: 20),
                widget,
                SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Widget buildPackageItem(PackagesData package) {
    return Container(
      width: double.infinity,
      height: 250.h,
      margin: EdgeInsets.all(10.r),
      child: Card(
        color: HexColor(AppColors.dotColor),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(top: 10.r, bottom: 10.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  image: DecorationImage(
                      image: NetworkImage('${package.image}'),
                      fit: BoxFit.cover)),
            ),
            Text(
                AppHelper.getAppLanguage() == 'ar'
                    ? '${package.titleAr}'
                    : '${package.titleEn}',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: Const.appFont,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('price'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 10.w),
                Text('${package.price}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('days'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 10.w),
                Text('${package.days}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Spacer(),
            CustomButton(
                text: 'enroll'.tr,
                width: 200.w,
                radius: 8.r,
                background: HexColor(AppColors.defualtColor),
                borderColor: AppColors.defualtColor,
                click: () async {
                  _controller.payNow(package.price!.toDouble());
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePayScreen(package: package)));
                  // if(Platform.isIOS){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePayScreen(package: package)));
                  // }else{
                  //   _controller.payNow(package.price!.toDouble());
                  // }
                }),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
