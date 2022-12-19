import 'dart:io';

import 'package:expectations/api/purchases_api.dart';
import 'package:expectations/controllers/packages_controller.dart';
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
  PackagesController _controller = Get.put(PackagesController());

  @override
  void initState() {
    super.initState();
    Purchases.addCustomerInfoUpdateListener(
        (customerInfo) => updateCustomerStatus());
    updateCustomerStatus();
  }

  Future updateCustomerStatus() async {
    final customerInfo = await Purchases.getCustomerInfo();
    // customerInfo.entitlements.active['Write here entitlements identifier'];
    customerInfo.entitlements.active['all_packages'];
  }

  @override
  Widget build(BuildContext context) {
    // AppHelper.clearData(key: Const.KEY_COUNTS_DAYS);
    print('DAYS COUNTS: ${AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS)}');
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
                return GetBuilder<PackagesController>(builder: (controller) => Expanded(
                    child: ListView.builder(
                        itemCount: _controller.listPackages.length,
                        itemBuilder: (context, index) => buildPackageItem(
                            _controller.listPackages[index]))));
                /*return Platform.isAndroid
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
                    );*/
              else if (snapshot.connectionState == ConnectionState.waiting)
                return Expanded(
                    child: CustomProgress());
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
                    // await PurchasesApi.purchaesProduct('Write here plan id');
                    await PurchasesApi.purchaesProduct('com.example.expectations.monthlyPlan35');
                    // await PurchasesApi.purchaesProduct('EXPECT001');

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
              child: CircleAvatar(
                backgroundImage: NetworkImage('${AppHelper.getTeamImage(package.image!)}'),
              ),
              margin: EdgeInsets.only(top: 30.r, bottom: 10.r),
            ),
            SizedBox(height: 10.h),
            Text(
                AppHelper.getAppLanguage() == 'ar'
                    ? '${package.titleAr}'
                    : '${package.titleEn}',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: Const.appFont,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800)),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('price'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 8.w),
                Text('${package.price}${Const.CURRENCY}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('days'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 8.w),
                Text('${package.days}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
                Text('day'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Const.appFont,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                    text: 'subscribe'.tr,
                    width: 150.w,
                    radius: 8.r,
                    background: HexColor(AppColors.defualtColor),
                    borderColor: AppColors.defualtColor,
                    click: () async {
                      _controller.days += 30;
                      if(AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS) != null){
                        int days = AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS);
                        print('CustomButton: $days');
                        if(days == 30){
                          _controller.days = 0;
                          AppHelper.showToast(message: 'you_aleardy_subscribe'.tr, color: Colors.green);
                        }else{
                          _controller.payNow(package.price!.toDouble());
                          AppHelper.saveAppData(key: Const.KEY_COUNTS_DAYS, value: _controller.days);
                        }
                      }else{
                        _controller.payNow(package.price!.toDouble());
                        AppHelper.saveAppData(key: Const.KEY_COUNTS_DAYS, value: _controller.days);
                      }
                      print('DAYS: ${_controller.days}');
                      print('DAYS: ${AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS)}');

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePayScreen(package: package)));
                      // if(Platform.isIOS){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePayScreen(package: package)));
                      // }else{
                      //   _controller.payNow(package.price!.toDouble());
                      // }
                    }),
                CustomButton(
                    text: 'unsubscribe'.tr,
                    isUpperCase: false,
                    radius: 8,
                    width: 150,
                    height: 48,
                    background: HexColor(AppColors.defualtColor),
                    borderColor: AppColors.defualtColor,
                    click: () async {
                      if(AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS) == null || AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS) == 0){
                        AppHelper.showToast(message: 'no_have_any_subscribe'.tr, color: Colors.green);
                      }else{
                        _controller.days = 0;
                        AppHelper.saveAppData(key: Const.KEY_COUNTS_DAYS, value: _controller.days);
                        AppHelper.showToast(message: 'done_cancel_subscribe'.tr, color: Colors.green);
                        print('DAYS: ${_controller.days}');
                        print('DAYS: ${AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS)}');
                      }
                    }),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
