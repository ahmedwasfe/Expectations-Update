
import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/live/comment/comments.dart';
import 'package:expectations/model/live/report.dart';
import 'package:expectations/model/live/viewers/viewer.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveController extends GetxController{

  List<LiveCommentData> listComments = [];
  List<ViewerData> listUsersOnline = [];
  RxBool isLike = false.obs;
  String reportSelected = '';
  late TextEditingController descController = TextEditingController();

  List<Report> reports = [
    Report(title: 'violent_extremism'.tr, isSelected: true),
    Report(title: 'illegal_activities'.tr, isSelected: false),
    Report(title: 'hate_behaviour'.tr, isSelected: false),
    Report(title: 'fraud_and_fraud'.tr, isSelected: false),
    Report(title: 'self_harm'.tr, isSelected: false),
    Report(title: 'harassment'.tr, isSelected: false),
    Report(title: 'violent_grotesque_content'.tr, isSelected: false),
    Report(title: 'wrong_info'.tr, isSelected: false),
    Report(title: 'Intellectual_property_infringement'.tr, isSelected: false),
  ];


  String getToken(){
    return AppHelper.getCurrentUserToken();
  }

  void createNewLive(){
    ApiRequests.newLive(token: getToken(), agoraToken: AppHelper.getLiveToken(key: Const.KEY_AGORA_TOKEN))
    .then((value) {
      if(value != null)
        AppHelper.saveAppData(key: Const.KEY_LIVE_ID, value: value.data!.id);
        AppHelper.saveLiveToken(key: Const.KEY_LIVE_TOKEN, token: value!.data!.token!);
        Const.LIVE_TOKEN = value.data!.token!;
        print('createNewLive LIVE_ID: ${AppHelper.getAppData(key: Const.KEY_LIVE_ID)}');
        print('createNewLive LIVE_TOKEN: ${Const.LIVE_TOKEN}');
      update();
    });
    update();
  }

  void closeLive(context, {required int liveId}){
    ApiRequests.closeLive(token: getToken(), liveId: liveId)
        .then((value) {
          AppHelper.clearData(key: Const.KEY_LIVE_ID);
          // AppHelper.clearData(key: Const.KEY_LIVE_TOKEN);
          Const.LIVE_TOKEN = '';
          Navigator.pop(context);
          update();
    });
    update();
  }

  void joinToBroadcast({required int liveId}) {
    ApiRequests.joinToBroadcast(token: getToken(), liveId: liveId);
  }

  void exitFromBroadcast(context, {required int liveId}){
    print('LIVEID: $liveId');
    ApiRequests.exitFromBroadcast(token: getToken(), liveId: liveId)
    .then((value) {
      Const.LIVE_TOKEN = '';
      Navigator.pop(context);
    });
  }

  void createComment({required int liveId, required String comment}) async {
    ApiRequests.createComment(token: getToken(), liveId: liveId, comment: comment)
        .then((value) {
          if(value != null){

            LiveCommentData data = LiveCommentData();
            data.id = value.data!.id;
            data.userId = value.data!.userid;
            data.liveId = int.parse(value.data!.liveid!);
            data.comment = value.data!.comment;
            data.createdAt = value.data!.createdat;
            data.updatedAt = value.data!.updatedat;
           listComments.add(data);
           getLiveComments(liveId: liveId);
          }
    });
  }

  Future<void> getUsers({required int liveId}) async {

    await ApiRequests.getViewers(token: getToken(), liveId: liveId)
        .then((value) {
          if(value != null){
            listUsersOnline.addAll(value.data!);
            print('USERS: ${jsonEncode(listUsersOnline)}');
          }
    });
  }

  void watchBroadcast({required int liveId}){
    ApiRequests.watchBroadcast(token: getToken(), liveId: liveId);
  }

  Future<void> getLiveComments({required int liveId}) async {
    await ApiRequests.getLiveComments(token: getToken(), liveId: liveId)
        .then((value) {
          if(value != null){
            listComments.addAll(value.data!);
          }
    });
  }

  void makeLike({required int liveId}){
    ApiRequests.makeLike(token: getToken(), liveId: liveId)
        .then((value) {
          isLike(true);
    });
  }

  void deleteLike({required int liveId}){
    ApiRequests.deleteLike(token: getToken(), liveId: liveId)
        .then((value) {
      isLike(false);
    });
  }

  void checkIsLike({required int liveId}){
    ApiRequests.checkIsLike(token: getToken(), liveId: liveId)
        .then((value) {
          if(value != null){
            if(value.data != null)
              isLike(true);
            else
              isLike(false);
          }
    });
  }

  void showReportBottomSheet(BuildContext context) {
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
            height: double.infinity,
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
                Text('report'.tr, style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
                SizedBox(height: 14),
                Expanded(
                  child:
                  GridView.builder(
                      shrinkWrap: true,
                      physics:
                      const BouncingScrollPhysics(),
                      itemCount: reports.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 8,  // TODO Space between start and End
                        mainAxisSpacing: 4, // TODO Space between Up and Dpwn
                        childAspectRatio: 60 / 20, // TODO SIZE GIRD
                        crossAxisCount: 2, // TODO Count Horrizantasl
                      ),
                      itemBuilder: (context, index) => GetBuilder<LiveController>(builder: (controller) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5).r,
                            border: Border.all(
                                color: HexColor(AppColors.greyColor)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: controller.reports[index].title,
                                groupValue: controller.reportSelected,
                                activeColor:
                                HexColor(AppColors.defualtColor),
                                onChanged: (value) {
                                  for (Report report in controller.reports) {
                                    report.isSelected = false;
                                    controller.update();
                                  }
                                  controller.reports[index].isSelected = true;
                                  controller.reportSelected = value.toString();

                                  controller.update();
                                  print('REPORT: ${controller.reportSelected}');
                                },
                              ),
                              Expanded(
                                child: Text(
                                    '${reports[index].title}'.tr,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500
                                    ),
                                maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ))))),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: Const.appFont),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 8),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                              controller: descController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: 'Description'.tr,
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: Const.appFont)),
                              validator: (value) =>
                                  AppHelper.validatePhone(phone: value!)),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: HexColor(AppColors.blackColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
                CustomButton(
                    text: 'submit'.tr,
                    width: 200,
                    height: 48,
                    radius: 8,
                    background: HexColor(AppColors.defualtColor),
                    isUpperCase: false,
                    borderColor: AppColors.defualtColor,
                    click: () => contactUs(context)),
              ],
            ),
          );
        });
  }

  void contactUs(BuildContext context) {

      print('ID: ${AppHelper.getUserId()}');
      print('PHONE: ${AppHelper.getUserData(key: Const.KEY_USER_DATA).phone}');
      print('TITLE: $reportSelected');
      print('DESC: ${descController.text}');
      ApiRequests.contactUs(
          userId: AppHelper.getUserId(),
          phone: AppHelper.getUserData(key: Const.KEY_USER_DATA).phone!,
          title: reportSelected,
          description: descController.text)
          .then((value) {
            reportSelected = '';
            descController.clear();
        Get.snackbar('sent'.tr, 'Thank you message sent'.tr, backgroundColor: Colors.white);
        Navigator.pop(context);
      }).catchError((error) {

        print('catchError: $error');
      });


  }

}