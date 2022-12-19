import 'package:expectations/api/purchases_api.dart';
import 'package:expectations/controllers/packages_controller.dart';
import 'package:expectations/controllers/register_controller.dart';
import 'package:expectations/model/Packages/packages.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class SubscribeScreen extends StatelessWidget {

  PackagesController _controller = Get.put(PackagesController());

  @override
  Widget build(BuildContext context) {
    // AppHelper.clearData(key: Const.KEY_COUNTS_DAYS);
    print('DAYS COUNTS: ${AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS)}');
    return Scaffold(
      body: Column(
        children: [
          MainToolBar(title: 'subscribe'.tr, isBack: true, route: Routes.home, isProfile: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20, top: 50),
                    child: Text(
                        'subscription_package'.tr,
                        style: TextStyle(
                            fontFamily: Const.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp
                        )),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 20, top: 30),
                    child: Text(
                        'subscription_package_text'.tr,
                        style: TextStyle(
                            fontFamily: Const.appFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp
                        )),
                  ),
                  FutureBuilder(
                      future: _controller.getPackages(),
                      builder: (context, snapShot) {
                        if(snapShot.connectionState == ConnectionState.done){
                          if(_controller.listPackages.isNotEmpty)
                            return GetBuilder<PackagesController>(builder: (controller) {
                              PackagesData package = controller.listPackages[0];
                              return Container(
                                width: double.infinity,
                                height: 200.h,
                                margin: EdgeInsets.all(10.r),
                                child: Card(
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
                                              color: HexColor(AppColors.defualtColor),
                                              fontFamily: Const.appFont,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(height: 14.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('price'.tr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: Const.appFont,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(width: 8.w),
                                          Text('34.99${Const.CURRENCY}',
                                              style: TextStyle(
                                                  color: HexColor(AppColors.defualtColor),
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
                                                  color: Colors.black,
                                                  fontFamily: Const.appFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(width: 8.w),
                                          Text('${package.days}',
                                              style: TextStyle(
                                                  color: HexColor(AppColors.defualtColor),
                                                  fontFamily: Const.appFont,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700)),
                                          Text('day'.tr,
                                              style: TextStyle(
                                                  color: HexColor(AppColors.defualtColor),
                                                  fontFamily: Const.appFont,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          else
                            return Container();
                        }else if(snapShot.connectionState == ConnectionState.waiting) {
                          return CustomProgress();
                        }else{
                          return Container(child: Text('NO Subsbcribe'),);
                        }

                      }),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50.r),
                    child: CustomButton(
                        text: 'subscribe'.tr,
                        isUpperCase: false,
                        radius: 8,
                        width: 250,
                        height: 48,
                        background: HexColor(AppColors.defualtColor),
                        borderColor: AppColors.defualtColor,
                        click: () async {
                          // await PurchasesApi.purchaesProduct('com.example.expectations.monthlyPlan35');
                          _controller.days += 30;
                          if(AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS) != null){
                            int days = AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS);
                            print('CustomButton: $days');
                            if(days == 30){
                              _controller.days = 0;
                              AppHelper.showToast(message: 'you_aleardy_subscribe'.tr, color: Colors.green);
                            }else{
                              await PurchasesApi.purchaesProduct('com.example.expectations.monthlyPlan35');
                              AppHelper.saveAppData(key: Const.KEY_COUNTS_DAYS, value: _controller.days);
                            }
                          }else{
                            await PurchasesApi.purchaesProduct('com.example.expectations.monthlyPlan35');
                            AppHelper.saveAppData(key: Const.KEY_COUNTS_DAYS, value: _controller.days);
                          }
                          print('DAYS: ${_controller.days}');
                          print('DAYS: ${AppHelper.getAppData(key: Const.KEY_COUNTS_DAYS)}');

                        }),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20.r),
                    child: CustomButton(
                        text: 'unsubscribe'.tr,
                        isUpperCase: false,
                        radius: 8,
                        width: 250,
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
