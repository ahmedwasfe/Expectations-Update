import 'dart:convert';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/model/match.dart';
import 'package:expectations/model/register.dart';
import 'package:expectations/model/user.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/components/components.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHelper extends GetxService {
  static late SharedPreferences _sharedPreferences;

  Future<AppHelper> initial() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  static dynamic getAppData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<dynamic> saveAppData(
      {required key, required dynamic value}) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is double) return await _sharedPreferences.setDouble(key, value);
  }

  static Future<bool> saveUserToken(
      {required key, required String token}) async {
    return await _sharedPreferences.setString(key, token);
  }

  static dynamic getUserToken({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> saveLiveToken(
      {required key, required String token}) async {
    return await _sharedPreferences.setString(key, token);
  }

  static dynamic getLiveToken({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> saveChannelName(
      {required key, required String channel}) async {
    return await _sharedPreferences.setString(key, channel);
  }

  static dynamic getChannelName({required String key}) {
    return _sharedPreferences.get(key);
  }

  static int getUserId() {
    if (getAppData(key: Const.KEY_LOGIN_REGISTER) == Const.Value_Login)
      return getUserData(key: Const.KEY_USER_DATA).id!;
    else if (getAppData(key: Const.KEY_LOGIN_REGISTER) == Const.Value_Register)
      return getRegisterData(key: Const.KEY_USER_DATA).id!;
    else
      return getUserData(key: Const.KEY_USER_DATA).id!;
  }

  static String getDateTody(){
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToday = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    return dateToday;
  }

  static String getExpiredDate() {
    if (getAppData(key: Const.KEY_LOGIN_REGISTER) == Const.Value_Login)
      return getUserData(key: Const.KEY_USER_DATA).exDate!;
    else if (getAppData(key: Const.KEY_LOGIN_REGISTER) == Const.Value_Register)
      return getRegisterData(key: Const.KEY_USER_DATA).exDate!;
    else
      return getUserData(key: Const.KEY_USER_DATA).exDate!;
  }

  static String getUserName() {
    if (getAppData(key: Const.KEY_LOGIN_REGISTER) == Const.Value_Login)
      return getUserData(key: Const.KEY_USER_DATA).name!;
    else if (getAppData(key: Const.KEY_LOGIN_REGISTER) == Const.Value_Register)
      return getRegisterData(key: Const.KEY_USER_DATA).name!;
    else
      return getUserData(key: Const.KEY_USER_DATA).name!;
  }

  static UserData getUserData({required String key}) {
    UserData userData = UserData();
    String? userDataJson = _sharedPreferences.getString(key);
    if (userDataJson != null)
      userData = UserData.fromJson(jsonDecode(userDataJson));
    return userData;
  }

  static RegisterData getRegisterData({required String key}) {
    RegisterData registerData = RegisterData();
    String? userDataJson = _sharedPreferences.getString(key);
    if (userDataJson != null)
      registerData = RegisterData.fromJson(jsonDecode(userDataJson));

    return registerData;
  }

  static Future<dynamic> saveUserData(
      {required String key, required UserData userData}) async {
    return await _sharedPreferences.setString(key, jsonEncode(userData));
  }

  static Future<dynamic> saveRegisterUserData(
      {required String key, required RegisterData registerData}) async {
    return await _sharedPreferences.setString(key, jsonEncode(registerData));
  }

  static Future<dynamic> saveBoardingData(
      {required String key, required dynamic boardingDate}) async {
    return await _sharedPreferences.setString(key, jsonEncode(boardingDate));
  }

  static dynamic getBoardingData({required String key}) {
    return _sharedPreferences.get(key);
  }

  // static List<BoardingData> getBoardingData({required String key}) {
  //   List<BoardingData> boardings = [];
  //   String? boardingDataJson = _sharedPreferences.getString(key);
  //   if (boardingDataJson != null) {
  //     BoardingData boardingData =
  //         BoardingData.fromJson(jsonDecode(boardingDataJson));
  //     boardings.add(boardingData);
  //   }
  //   return boardings;
  // }

  static Future<bool> clearData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await _sharedPreferences.clear();
  }

  static String getCurrentUserToken() {
    if (getUserToken(key: Const.KEY_USER_TOKEN) != null) {
      return 'Bearer ${getUserToken(key: Const.KEY_USER_TOKEN)}';
    } else
      return '';
  }

  static RegExp emailValidate() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  }

  static String getTeamHomeImage(Match match) {
    return match.teamHome!.image!.replaceAll('\\', '/');
  }


  static String getTeamAwayImage(Match match) {
    return match.teamAway!.image!.replaceAll('\\', '/');
  }

  static String getTeamImage(String image){
    return '${ApiRequests.imageUrl}${formateTeamImage(image)}';
  }

  static String formateTeamImage(String pathImage) {
    if(pathImage.contains('\\'))
      return pathImage.replaceAll('\\', '/');
    else
      return pathImage;
  }

  static String loadImagePath(String imagePath){
    return 'https://tawaq3.com/expectations/$imagePath';
  }

  static String formatMatchTime(Match match) {
    return match.timing!.substring(11, 16);
  }

  static String formatTime(String time) {
    return time.substring(11, 16);
  }

  static String formatMatchDate(Match match) {
    return match.timing!.substring(0, 10);
  }

  static String? validateName({required String name}) {
    if (name.isEmpty)
      return 'Enter your name'.tr;
    else
      return null;
  }

  static String? validateDateOfBirth({required dateOfBirth}) {
    if (GetUtils.isBlank(dateOfBirth)!)
      return 'choose your age'.tr;
    else
      return null;
  }

  static String? validateEmail({required email}) {
    if (GetUtils.isBlank(email)!)
      return 'enter email'.tr;
    else if (!AppHelper.emailValidate().hasMatch(email))
      return 'Enter a valid email'.tr;
    else
      return null;
  }

  static String? validatePassword({required String password}) {
    if (GetUtils.isBlank(password)!)
      return 'Enter Password'.tr;
    else if (password.length < 6)
      return 'Password must be more than 6 characters'.tr;
    else
      return null;
  }

  static String? validateConfirmPassword(
      {required String password, required String conformPassword}) {
    if (GetUtils.isBlank(conformPassword)!)
      return 'Enter Confirm Password'.tr;
    else if (conformPassword.length < 6)
      return 'Password must be more than 6 characters'.tr;
    else if (password != conformPassword) return 'Passwords do not match'.tr;
    return null;
  }

  static String? validateAddress({required String address}) {
    if (GetUtils.isBlank(address)!)
      return 'Enter your preferred address'.tr;
    else
      return null;
  }

  static String? validatePhone({required String phone}) {
    if (GetUtils.isBlank(phone)!)
      return 'Enter the phone number'.tr;
    else
      return null;
  }

  static String? validateSport({required String sport}) {
    if (GetUtils.isBlank(sport)!)
      return 'Enter your athletic inclination'.tr;
    else
      return null;
  }

  static String? validateTitle({required String title}) {
    if (title.isEmpty)
      return 'Enter the message title'.tr;
    else
      return null;
  }

  static String? validateDescription({required String description}) {
    if (description.isEmpty)
      return 'Enter a simple description of the message'.tr;
    else
      return null;
  }

  static String getDefaultImage(){
    return 'https://i.postimg.cc/B6GcTk8F/default-avatar2.png';
  }

  static String getUrlImage(){
    return 'https://tawaq3.com/expectations/';
  }

  static String getAppLanguage(){
    if(getAppData(key: Const.KEY_LANGUAGE) != null && getAppData(key: Const.KEY_LANGUAGE) != ""){
      String language = getAppData(key: Const.KEY_LANGUAGE);
      if(language == "ar")
        return "ar";
      else if(language == "en")
        return "en";
    }
    return "ar";
  }

  static int getLiveId(){
    if(getAppData(key: Const.KEY_LIVE_ID) != null)
      return getAppData(key: Const.KEY_LIVE_ID);
    else return 0;
  }

  static void showToast({required String message, Color color = Colors.black}){
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static void showLoginDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (con) => AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  'please_login'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: Const.appFont),
                ),
                Container(
                    margin: EdgeInsets.only(top: 50),
                    child: CustomButton(
                        radius: 8,
                        background: HexColor(AppColors.defualtColor),
                        text: 'login'.tr,
                        click: () => Get.offAndToNamed(Routes.login))
                ),
              ],
            ),
          ),
        ));
  }
}
