import 'dart:convert';

import 'package:expectations/model/Packages/payment.dart';
import 'package:expectations/model/add_favorite.dart';
import 'package:expectations/model/ads.dart';
import 'package:expectations/model/awards.dart';
import 'package:expectations/model/boarding.dart';
import 'package:expectations/model/contact_us.dart';
import 'package:expectations/model/delete_account.dart';
import 'package:expectations/model/delete_favorite.dart';
import 'package:expectations/model/favorite.dart';
import 'package:expectations/model/forget_password.dart';
import 'package:expectations/model/home_matches/home_matches.dart';
import 'package:expectations/model/live/agora_token.dart';
import 'package:expectations/model/live/all_live.dart';
import 'package:expectations/model/live/close_live.dart';
import 'package:expectations/model/live/comment/comments.dart';
import 'package:expectations/model/live/comment/create_comment.dart';
import 'package:expectations/model/live/like/delete_like.dart';
import 'package:expectations/model/live/like/likes.dart';
import 'package:expectations/model/live/like/make_like.dart';
import 'package:expectations/model/live/new_live.dart';
import 'package:expectations/model/live/viewers/viewer.dart';
import 'package:expectations/model/live/viewers/watch_broadcast.dart';
import 'package:expectations/model/logout.dart';
import 'package:expectations/model/match_prediction.dart';
import 'package:expectations/model/notifications.dart';
import 'package:expectations/model/Packages/packages.dart';
import 'package:expectations/model/periodicals.dart';
import 'package:expectations/model/profile.dart';
import 'package:expectations/model/register.dart';
import 'package:expectations/model/reset_password.dart';
import 'package:expectations/model/response_error.dart';
import 'package:expectations/model/search.dart';
import 'package:expectations/model/user.dart';
import 'package:expectations/model/user_expectations.dart';
import 'package:expectations/model/winners.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiRequests {
  static String _baseUrl = 'https://cp.tawaq3.com/api';
  static String imageUrl = 'https://cp.tawaq3.com/';
  // static String _baseUrl = 'https://tawaq3.com/expectations/api';
  // static String imageUrl = 'https://tawaq3.com/expectations/';
  static String _urlToken =
      'https://agora-node-tokenserver.ahmetmandil.repl.co/access_token';
  static var _client = http.Client();

  // https://apiv3.apifootball.com/?action=get_events&from=2022-09-03&to=2022-09-03&APIkey=9620270638bf3a273bb0f4c572cf97b6d49b454069d00e6aadf97fb3cafe53d7
  static String url = 'https://apiv3.apifootball.com/?action=get_events';

  static Future<HomeMatches?> fetchHomeMatches({
    required String from,
    required String to,
  }) async {
    http.Response response = await _client.get(
      // home/matchs?from=2022-09-03&to=2022-09-03
      Uri.parse('$_baseUrl/home/matchs?from=$from&to=$to'),
    );
    print('ERROR: ${jsonDecode(response.body)}');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      HomeMatches matches = HomeMatches.fromJson(body);

      // print('RESPONSE: ${jsonEncode(matches)}');
      return matches;
    } else {
      print('ERROR: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<AgoraToken?> getAgorToken() async {
    http.Response response = await _client.get(Uri.parse(_urlToken));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      AgoraToken token = AgoraToken.fromJson(body);
      print('SUCCESS getAgorToken: ${jsonEncode(token)}');
      return token;
    } else {
      print('ERROR getAgorToken: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<String?> getIPAddress() async {
    try {
      final url = Uri.parse('https://api.ipify.org');
      http.Response response = await http.get(url);
      return response.statusCode == 200 ? response.body : null;
    } catch (e) {
      return null;
    }
  }

  static Future<Register> createAccount(
      {required name,
      required email,
      required password,
      required confirmPassword,
      required phone,
      required dateOfBirth,
      required address,
      required String ipAddress,
      fcmToken}) async {
    http.Response response = await _client.post(Uri.parse('$_baseUrl/register'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(
          <String, dynamic>{
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": confirmPassword,
            "phone": phone,
            "date_of_birth": dateOfBirth,
            "address": address,
            "ip_address": ipAddress,
            "fcm_token": fcmToken
          },
        ));
    Register user = Register();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      user = Register.fromJson(body);
      return user;
    } else {
      var body = jsonDecode(response.body);
      user = Register.message(body);
      if (user.message == 'The email has already been taken.')
        Get.snackbar('Account creation error'.tr,
            'This email is used by someone else'.tr);
      else if (user.message == "The name has already been taken.")
        Get.snackbar('Login Error'.tr, 'name_taken'.tr);
      else if (user.message == "The ip address has already been taken.")
        Get.snackbar('Login Error'.tr, 'ip_address_taken'.tr);
      print('Error Register ${response.statusCode}: ${response.body}');
      return user;
    }
  }

  static Future<User?> login({required email, required password, token}) async {
    var response = await _client.post(Uri.parse('$_baseUrl/login'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(
          <String, dynamic>{"email": email, "password": password},
        ));
    User user = User();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      user = User.fromJson(body);
      print('SUUCCESS: ${jsonEncode(user)}');
      return user;
    } else {
      var body = jsonDecode(response.body);
      user = User.message(body);
      if (user.message == 'api.password_wrong')
        Get.snackbar('Login Error'.tr, 'The entered password is incorrect'.tr);
      else if (user.message == 'api.email_not_found')
        Get.snackbar('Login Error'.tr,
            'This email is not associated with any account'.tr);
      else
        Get.snackbar('Login Error'.tr,
            'There is an error, please check all the data entered'.tr);
      print('Error Login: ${response.statusCode}: ${response.body}');
      return user;
    }
  }

  static Future<ForgetPassword?> forgetpassword({required String email}) async {
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/forgot-password'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(
        <String, dynamic>{"email": email},
      ),
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print("Response: $body");
      ForgetPassword forgetPassword = ForgetPassword.fromJson(body);
      return forgetPassword;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<ResetPassword> resetPassword(
      {required String token,
        required String oldPassword,
        required String newPassword,
        required String confirmPassword}) async {
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/reset-password'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
      body: jsonEncode(<String, dynamic>{
        "old_password": oldPassword,
        "new_password": newPassword,
        "confirm_password": confirmPassword
      }),
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print("Reponse: $body");
      ResetPassword resetPassword = ResetPassword.fromJson(body);
      return resetPassword;
    } else {
      var body = jsonDecode(response.body);
      ResetPassword resetPassword = ResetPassword.message(body);
      print('Error: ${response.body}');
      return resetPassword;
    }
  }

  static Future<Packages?> getPackages() async {
    http.Response response = await _client.get(Uri.parse('$_baseUrl/packages'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Packages packages = Packages.fromJson(body);
      // print('SUCCESS: ${jsonEncode(packages)}');
      return packages;
    } else {
      print('ERROR: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<Payment?> payment(
      {required String token,
      required int packageId,
      required int paymentId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/order/store'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{
          'package_id': '$packageId',
          'payment_id': '$paymentId',
        }));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Payment payment = Payment.fromJson(body);
      print('Success payment: ${jsonEncode(payment)}');
      return payment;
    } else {
      print('ERROR payment: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<Boarding?> fetchBoardings() async {
    http.Response response = await _client.get(Uri.parse('$_baseUrl/setting'),
        headers: {'Content-type': 'application/json'});
    List<BoardingData> boardings = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Boarding boarding = Boarding.fromJson(body);
      // print('BOARDINGS: ${jsonEncode(boarding)}');
      return boarding;
    }
    return null;
  }

  static Future<Search?> search({required String word}) async {
    http.Response response = await _client.post(Uri.parse('$_baseUrl/search'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(<String, dynamic>{"key": word}));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      Search search = Search.fromJson(body);
      return search;
    } else {
      print('Error Search ${response.body}');
      return null;
    }
  }

  static Future<Ads?> fetchAds() async {
    http.Response response = await _client.get(Uri.parse('$_baseUrl/ads'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print("fetchAds ADS: $body");
      Ads ads = Ads.fromJson(body);
      return ads;
    }
    return null;
  }

  static Future<Periodicals?> fetchPeriodicals({required String token}) async {
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/periodicals'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      Periodicals periodicals = Periodicals.fromJson(body);
      return periodicals;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<Periodicals?> fetchPeriodicalsByDate(
      {required String token, required String date}) async {
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/periodicals'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
      body: jsonEncode(<String, String>{"key": date}),
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      Periodicals periodicals = Periodicals.fromJson(body);
      return periodicals;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<MatchPrediction?> matchPrediction({
    required String token,
    required int matchId,
    required int resultHome,
    required int resultAway,
  }) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/expectations/store'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{
          "match_id": matchId,
          "result_1": resultHome,
          "result_2": resultAway
        }));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      MatchPrediction matchPrediction = MatchPrediction.fromJson(body);
      return matchPrediction;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<UserExpectations?> fetchExpectations(
      {required String token}) async {
    http.Response response = await _client.get(
        Uri.parse('$_baseUrl/expectations'),
        headers: {'Content-type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      UserExpectations expectations = UserExpectations.fromJson(body);
      return expectations;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<AddFavorite?> addToFavorite(
      {required String token, required int matchId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/favorite/store'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{"match_id": matchId}));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      AddFavorite favorite = AddFavorite.fromJson(body);
      return favorite;
    } else {
      print('Error Add Favorite: ${response.body}');
      return null;
    }
  }

  static Future<DeleteFavorite?> removeFromFavorite(
      {required String token, required int matchId}) async {
    http.Response response = await _client.delete(
      Uri.parse('$_baseUrl/favorite/destroy/$matchId'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      DeleteFavorite favorite = DeleteFavorite.fromJson(body);
      return favorite;
    } else {
      print('Error Delete Favorite: ${response.body}');
      return null;
    }
  }

  static Future<Favorite?> fetchFavorites({required String token}) async {
    http.Response response = await _client.get(Uri.parse('$_baseUrl/favorite'),
        headers: {'Content-type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('fetchFavorites: ${body}');
      Favorite favorite = Favorite.fromJson(body);
      return favorite;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<Notifications?> fetchNotifications() async {
    http.Response response =
        await _client.get(Uri.parse('$_baseUrl/notifications'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      Notifications notifications = Notifications.fromJson(body);
      return notifications;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<Profile?> fetchUserData({required String token}) async {
    http.Response response = await _client.get(
        Uri.parse('$_baseUrl/user/profile'),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      Profile profile = Profile.fromJson(body);
      return profile;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<Profile?> editProfile(
      {required String name,
      required String email,
      required String phone,
      required String dateOfBirth,
      required String address,
      required String token,
      String? image}) async {
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/user/update'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
      body: jsonEncode(
        <String, dynamic>{
          "name": name,
          "email": email,
          "phone": phone,
          "date_of_birth": dateOfBirth,
          "address": address,
          // "image": image
        },
      ),
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Profile profile = Profile.fromJson(body);
      return profile;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<ContactUs?> contactUs({
    required int userId,
    required String phone,
    required String title,
    required String description,
  }) async {
    http.Response response =
        await _client.post(Uri.parse('$_baseUrl/connect_us/store'),
            headers: {'Content-type': 'application/json'},
            body: jsonEncode(
              <String, dynamic>{
                "user_id": userId,
                "title": title,
                "phone": phone,
                "description": description
              },
            ));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      ContactUs contactUs = ContactUs.fromJson(body);
      return contactUs;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<Winners?> fetchWinners({required int matchId}) async {
    http.Response response = await _client.get(
        Uri.parse('$_baseUrl/winners/$matchId'),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      // print('Response: $body');
      Winners winners = Winners.fromJson(body);
      return winners;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<Awards?> fetchAwards({required int matchId}) async {
    http.Response response = await _client.get(
        Uri.parse('$_baseUrl/awards/$matchId'),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print('Response: $body');
      Awards awards = Awards.fromJson(body);
      return awards;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  // New LIve
  static Future<NewLive?> newLive(
      {required String token, required String agoraToken}) async {
    print('newLive TOKEN: $agoraToken');
    http.Response response = await _client.post(Uri.parse('$_baseUrl/live'),
        body: jsonEncode(<String, dynamic>{'token': '$agoraToken'}),
        headers: {'Content-type': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      NewLive live = NewLive.fromJson(body);
      print('SUCCESS newLive: ${jsonEncode(live)}');
      return live;
    } else {
      print('ERROR newLive: ${jsonDecode(response.body)}');
      var body = jsonDecode(response.body);
      ResponseError error = ResponseError.fromJson(body);
      AppHelper.showToast(message: error.data!);
      print('ERROR newLive: ${jsonEncode(error)}');
      return null;
    }
  }

  // Close Live
  static Future<CloseLive?> closeLive(
      {required String token, required int liveId}) async {
    print('closeLive Id: $liveId');
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/live/close'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
      body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}),
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      CloseLive live = CloseLive.fromJson(body);
      // print('RESPONSE closeLive: ${jsonEncode(live)}');
      return live;
    } else {
      print('ERROR closeLive: ${jsonDecode(response.body)}');
      return null;
    }
  }

  // Join to Live
  static Future<Broadcast?> joinToBroadcast(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/participants'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Broadcast broadcast = Broadcast.fromJson(body);
      print('SUCCESS watchBroadcast: ${jsonEncode(broadcast)}');
      return broadcast;
    } else {
      print('ERROR watchBroadcast: ${jsonDecode(response.body)}');
      return null;
    }
  }

  // Exit from Live
  static Future<Broadcast?> exitFromBroadcast(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/participants/close'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print('SUCCESS exitBroadcast: ${jsonEncode(body)}');
      Broadcast broadcast = Broadcast.fromJson(body);
      print('SUCCESS exitBroadcast: ${jsonEncode(broadcast)}');
      return broadcast;
    }else {
      print('ERROR exitBroadcast: ${jsonDecode(response.body)}');
      return null;
    }
  }

  // Watch Live
  static Future<Broadcast?> watchBroadcast(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/viewers'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Broadcast broadcast = Broadcast.fromJson(body);
      print('SUCCESS watchBroadcast: ${jsonEncode(broadcast)}');
      return broadcast;
    } else {
      print('ERROR watchBroadcast: ${jsonDecode(response.body)}');
      return null;
    }
  }

  // get All users in live
  static Future<Viewer?> getViewers(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/viewers/show'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Viewer viewer = Viewer.fromJson(body);
      print('SUCCESS getViewers: ${jsonEncode(viewer)}');
      return viewer;
    } else {
      print('ERROR getViewers: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<AllLive?> getAllLive() async {
    http.Response response = await _client.get(Uri.parse('$_baseUrl/live'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      AllLive live = AllLive.fromJson(body);
      print('RESPONSE getAllLive: ${jsonEncode(body)}');
      return live;
    } else {
      print('ERROR: getAllLive: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<CreateComment?> createComment(
      {required String token,
      required int liveId,
      required String comment}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/comments'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(
            <String, dynamic>{'live_id': '$liveId', 'comment': comment}));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      CreateComment comment = CreateComment.fromJson(body);
      // print('SUCCESS createComment: ${jsonEncode(comment)}');
      return comment;
    } else {
      print('ERROR createComment: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<LiveComments?> getLiveComments(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/comments/show'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '${liveId}'}));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      LiveComments comments = LiveComments.fromJson(body);
      // print('SUCCESS getLiveComments: ${jsonEncode(comments)}');
      return comments;
    } else {
      // print('ERROR getLiveComments: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<MakeLike?> makeLike(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/like'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      MakeLike like = MakeLike.fromJson(body);
      print('SUCCESS makeLike: ${jsonEncode(like)}');
      return like;
    } else {
      print('ERROR makeLike: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<DeleteLike?> deleteLike(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/like/delete'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      DeleteLike like = DeleteLike.fromJson(body);
      print('SUCCESS deleteLike: ${jsonEncode(like)}');
      return like;
    } else {
      print('ERROR deleteLike: ${jsonDecode(response.body)}');
      return null;
    }
  }

  static Future<Likes?> checkIsLike(
      {required String token, required int liveId}) async {
    http.Response response = await _client.post(
        Uri.parse('$_baseUrl/live/like/show'),
        headers: {'Content-type': 'application/json', 'Authorization': token},
        body: jsonEncode(<String, dynamic>{'live_id': '$liveId'}));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Likes likes = Likes.fromJson(body);
      print('SUCCESS getLiveLikes: ${jsonEncode(likes)}');
      return likes;
    } else {
      print('SUCCESS getLiveLikes: ${jsonEncode(response.body)}');
      return null;
    }
  }

  static Future<Logout?> logout({required String token}) async {
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/logout'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Logout logout = Logout.fromJson(body);
      return logout;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  static Future<DeleteAccount?> deleteAccount({required String token}) async {
    http.Response response = await _client.post(
      Uri.parse('$_baseUrl/delete'),
      headers: {'Content-type': 'application/json', 'Authorization': token},
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      DeleteAccount deleteAccount = DeleteAccount.fromJson(body);
      print('SUCCES: ${jsonEncode(deleteAccount)}');
      return deleteAccount;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }
}
