import 'package:expectations/controllers/register_controller.dart';
import 'package:expectations/model/Packages/packages.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  RegisterController _controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120.h,
            decoration: BoxDecoration(
                color: HexColor(AppColors.defualtColor),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r))),
            child: Container(
              margin: EdgeInsets.only(top: 40.r),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'packages'.tr,
                      style: TextStyle(
                          color: HexColor(AppColors.whiteColor),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: Const.appFont),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: _controller.getPackages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Expanded(
                  child: ListView.builder(
                      itemCount: _controller.listPackages.length,
                      itemBuilder: (context, index) =>
                          buildPackageItem(_controller.listPackages[index])),
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

  Widget buildPackageItem(PackagesData package) => Container(
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
                        image: NetworkImage(
                            '${AppHelper.getUrlImage()}${package.image}'),
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
                  click: () {
                    Future.delayed(Duration(seconds: 3), () => AppHelper.showToast(message: 'an error occurred'), );
                    // _controller.payNow(package.price!.toDouble());
                  }),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      );
}
