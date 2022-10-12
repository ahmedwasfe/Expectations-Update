import 'package:expectations/controllers/boarding_controller.dart';
import 'package:expectations/model/boarding.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends GetView<BoardingsController> {
  BoardingScreen({Key? key}) : super(key: key);

  BoardingsController _controller = Get.put(BoardingsController());
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: 18.h),
          FutureBuilder(
              future: _controller.fetchBoardings(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(_controller.listBoardings.isNotEmpty)
                    return PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return PageViewScreens(_controller.listBoardings[index], _controller.listBoardings, index);
                      },
                      onPageChanged: (int index) {
                        if (index == _controller.listBoardings.length - 2)
                          _controller.isLast.value = true;
                        else
                          _controller.isLast.value = false;
                      },
                    );
                  else
                    return Container();
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Center(child: CircularProgressIndicator());
                    },
                    onPageChanged: (int index) {
                      if (index == _controller.listBoardings.length - 2)
                        _controller.isLast.value = true;
                      else
                        _controller.isLast.value = false;
                    },
                  );
                }
                else{
                  return PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                    onPageChanged: (int index) {
                      if (index == _controller.listBoardings.length - 2)
                        _controller.isLast.value = true;
                      else
                        _controller.isLast.value = false;
                    },
                  );
                }
              }),
          Container(
            margin: EdgeInsets.only(top: 100.r),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: CustomizableEffect(
                dotDecoration: DotDecoration(
                  height: 4.h,
                  width: 15.w,
                  color: HexColor(AppColors.dotColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                activeDotDecoration: DotDecoration(
                  height: 4.h,
                  width: 35.w,
                  color: HexColor(AppColors.dotActiveColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onDotClicked: (index) {
                if (_controller.isLast.value)
                  pageController.previousPage(
                      duration: Duration(milliseconds: 750),
                      curve: Curves.easeInToLinear);
                else
                  pageController.nextPage(
                      duration: Duration(milliseconds: 750),
                      curve: Curves.easeInToLinear);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 550.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Text('skip'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          color: Colors.black,
                          fontFamily: '${Const.appFont}',
                          decoration: TextDecoration.underline)),
                  onTap: () => _controller.goToLogin(),
                ),
                SizedBox(height: 20.h),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                  elevation: 16.r,
                  backgroundColor: HexColor(AppColors.defualtColor),
                  onPressed: () {
                    if (_controller.isLast.value)
                      _controller.goToLogin();
                    else
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInToLinear);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
