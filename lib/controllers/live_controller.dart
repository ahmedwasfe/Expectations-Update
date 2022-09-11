
import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/live/comment/comments.dart';
import 'package:expectations/model/live/viewers/viewer.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveController extends GetxController{

  List<LiveCommentData> listComments = [];
  List<ViewerData> listUsersOnline = [];
  RxBool isLike = false.obs;

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
        print('LIVE_ID: ${AppHelper.getAppData(key: Const.KEY_LIVE_ID)}');
        print('LIVE_TOKEN: ${Const.LIVE_TOKEN}');
    });
  }

  void closeLive(context, {required int liveId}){
    ApiRequests.closeLive(token: getToken(), liveId: liveId)
        .then((value) {
          AppHelper.clearData(key: Const.KEY_LIVE_ID);
          // AppHelper.clearData(key: Const.KEY_LIVE_TOKEN);
          Const.LIVE_TOKEN = '';
          Navigator.pop(context);
    });
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

}