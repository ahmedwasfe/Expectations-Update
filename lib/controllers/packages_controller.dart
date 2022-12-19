import 'dart:convert';
import 'dart:io';

import 'package:expectations/api/api_requests.dart';
import 'package:expectations/api/purchases_api.dart';
import 'package:expectations/model/Packages/packages.dart';
import 'package:expectations/model/Packages/payment.dart';
import 'package:expectations/model/user.dart';
import 'package:expectations/shared/components/constants.dart';
import 'package:expectations/ui/widget/pay_wall_widget.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PackagesController extends GetxController{

  Payment paymentData = Payment();
  List<PackagesData> listPackages = [];
  List<Package> packages = [];
  int days = 0;

  Future<void> getPackages() async {
    await ApiRequests.getPackages()
        .then((value) {
      if (value != null) {
        listPackages.clear();
        listPackages.addAll(value.data!);
        // print('PACKAGES: ${listPackages.length}');
        update();
      }
    });
    update();
  }

  Future fetchOffers(BuildContext context) async {
    final offerings = await PurchasesApi.fetchOfferes();
    if(offerings.isEmpty)
      AppHelper.showToast(message: 'No Plans Found', color: Colors.redAccent);
    else{
      final offer = offerings.first;
      final packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
      print('fetchOffers OFFER: $offer');
      this.packages.clear();
      this.packages.addAll(packages);
      showBottomSheet(context: context, builder: (context) => PayWallWidget(title: 'Title sdd', description: 'Description dssds', packages: packages, onCLickPackage: (package){
        PurchasesApi.purchaesPackage(package);
      }));
    }
  }

// TODO Real KEY
/*
  * TODO profileId: "92423",
  * TODO serverKey: "SZJN2WKRDB-JGD2TB6HJ9-H6JZW2ZWNK",
    TODO clientKey: "CDKMQK-R9N96T-DM72GH-2NDTVN",

      serverKey: "SZJN2WKR9R-JGKG2D9996-RJW2L9629K",
      clientKey: "CRKMQK-R97T6T-KTMDPP-7NHB9Q",
  * */

// TODO Test KEY
/*
    * TODO profileId: "91958",
    * TODO serverKey: "STJN2WKRKZ-JGB9BWTJTG-HHRLDZWDBJ",
    * TODO clientKey: "CRKMQK-R9BH6T-2P2V76-BBBHVP",
    *
    * */

// TODO Payment
  PaymentSdkConfigurationDetails generateConfig(double amount) {

    String username = AppHelper.getUserName();
    UserData? user = AppHelper.getUserData(key: Const.KEY_USER_DATA);
    print('username: $username');
    print('User username: ${user.name}');

    var billingDetails = BillingDetails(
        "$username",
        "${user.email}",
        "${user.phone}", "${user.address}", "", "", "", "12313");

    var shippingDetails = ShippingDetails(
        "$username",
        "${user.email}",
        "${user.phone}", "${user.address}", "", "", "", "12313");

    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);


    var configuration = PaymentSdkConfigurationDetails(
        profileId: "92423",
        serverKey: "SZJN2WKRDB-JGD2TB6HJ9-H6JZW2ZWNK",
        clientKey: "CDKMQK-R9N96T-DM72GH-2NDTVN",
        // serverKey: "SZJN2WKR9R-JGKG2D9996-RJW2L9629K", // New
        // clientKey: "CRKMQK-R97T6T-KTMDPP-7NHB9Q", // New
        cartId: "Sample Payment",
        cartDescription: "Twaq3",
        merchantName: "Twaq3 App",
        screentTitle: "Pay with Card",
        amount: amount,
        locale: AppHelper.getAppLanguage() == 'ar' ? PaymentSdkLocale.AR : PaymentSdkLocale.EN,
        showBillingInfo: true,
        showShippingInfo: true,
        forceShippingInfo: false,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();

    theme.logoImage = "assets/icons/logo41.png";

    if(Platform.isIOS){
      configuration.simplifyApplePayValidation = true;
      configuration.iOSThemeConfigurations = theme;
    }else{
      configuration.iOSThemeConfigurations = theme;
    }

    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payNow(double amount) async {

    FlutterPaytabsBridge.startCardPayment(generateConfig(amount), (event) {
      if (event["status"] == "success") {
        // Handle transaction details here.
        var transactionDetails = event["data"];
        print('success: $transactionDetails');
        if (transactionDetails["isSuccess"]) {
          var transactionDetails = event["data"];
          print('isSuccess: $transactionDetails');
          AppHelper.showToast(message: 'done payment successfully'.tr, color: Colors.green);
          AppHelper.saveAppData(key: Const.KEY_COUNTS_DAYS, value: 30);
        } else {
          print("failed transaction");
        }
      } else if (event["status"] == "error") {
        // Handle error here.
        var transactionDetails = event["data"];
        print('error: $transactionDetails');
        print('error: ${event["status"]}');
      } else if (event["status"] == "event") {
        // Handle events here.
        var transactionDetails = event["data"];
        print('event: $transactionDetails');
      }
      update();
    })
        .then((value) {
      print('startCardPayment: ${jsonEncode(value)}');
    });
  }
  PaymentSdkConfigurationDetails generateAppleConfig(double amount) {

    String username = AppHelper.getUserName();
    UserData? user = AppHelper.getUserData(key: Const.KEY_USER_DATA);
    // print('username: $username');
    // print('User username: ${user.name}');

    var billingDetails = BillingDetails(
        "$username",
        "${user.email}",
        "${user.phone}", "${user.address}", "", "", "", "12313");

    var shippingDetails = ShippingDetails(
        "$username",
        "${user.email}",
        "${user.phone}", "${user.address}", "", "", "", "12313");

    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.AMAN);


    var configuration = PaymentSdkConfigurationDetails(
        profileId: "92423",
        // serverKey: "SZJN2WKRDB-JGD2TB6HJ9-H6JZW2ZWNK",
        // clientKey: "CDKMQK-R9N96T-DM72GH-2NDTVN",
        serverKey: "SZJN2WKR9R-JGKG2D9996-RJW2L9629K",
        clientKey: "CRKMQK-R97T6T-KTMDPP-7NHB9Q",
        // profileId: "91958",
        // serverKey: "STJN2WKRKZ-JGB9BWTJTG-HHRLDZWDBJ",
        // clientKey: "CRKMQK-R9BH6T-2P2V76-BBBHVP",
        cartId: "c21d8933-3c43-4eb3-9993-9c2654ccfd44",
        cartDescription: "Follow up",
        merchantName: "Twaq3 App",
        screentTitle: 'Pay with Apple',
        locale: AppHelper.getAppLanguage() == 'ar' ? PaymentSdkLocale.AR : PaymentSdkLocale.EN,
        amount: amount,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        merchantApplePayIndentifier: "merchant.com.example.expectations",
        simplifyApplePayValidation: true,

        showBillingInfo: true,
        showShippingInfo: true,
        forceShippingInfo: false,
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();

    theme.logoImage = "assets/icons/logo41.png";

    if(Platform.isIOS){
      configuration.simplifyApplePayValidation = true;
      configuration.iOSThemeConfigurations = theme;
    }else{
      configuration.iOSThemeConfigurations = theme;
    }

    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payWithApple(double amount) async {

    var configuration = PaymentSdkConfigurationDetails(
      profileId: "92423",
      // serverKey: "SZJN2WKRDB-JGD2TB6HJ9-H6JZW2ZWNK",
      // clientKey: "CDKMQK-R9N96T-DM72GH-2NDTVN",
      serverKey: "SZJN2WKR9R-JGKG2D9996-RJW2L9629K",
      clientKey: "CRKMQK-R97T6T-KTMDPP-7NHB9Q",
      // profileId: "91958",
      // serverKey: "STJN2WKRKZ-JGB9BWTJTG-HHRLDZWDBJ",
      // clientKey: "CRKMQK-R9BH6T-2P2V76-BBBHVP",
      cartId: "c21d8933-3c43-4eb3-9993-9c2654ccfd44",
      cartDescription: "Follow up",
      merchantName: "Twaq3 App",
      screentTitle: 'Pay with Card',
      locale: AppHelper.getAppLanguage() == 'ar' ? PaymentSdkLocale.AR : PaymentSdkLocale.EN,
      amount: amount,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      merchantApplePayIndentifier: "merchant.com.example.expectations",
      linkBillingNameWithCardHolderName: true,
      simplifyApplePayValidation: true,
      forceShippingInfo : false,
      showBillingInfo : false,
      showShippingInfo : false,
    );
    print('configuration: $configuration');

    FlutterPaytabsBridge.startApplePayPayment(generateAppleConfig(amount), (event) {
      if (event["status"] == "success") {
        // Handle transaction details here.
        var transactionDetails = event["data"];
        print('success: $transactionDetails');
        if (transactionDetails["isSuccess"]) {
          var transactionDetails = event["data"];
          print('isSuccess: $transactionDetails');
          AppHelper.showToast(message: 'done payment successfully'.tr, color: Colors.green);
        } else {
          AppHelper.showToast(message: 'not isSuccess, failed transaction'.tr, color: Colors.redAccent);

          print("failed transaction");
        }
      } else if (event["status"] == "error") {
        // Handle error here.
        var transactionDetails = event["data"];
        print('error: ${transactionDetails}');
        print('error: ${event["status"]}');
        AppHelper.showToast(message: 'status; payment error: ${transactionDetails}', color: Colors.redAccent);
      } else if (event["status"] == "event") {
        // Handle events here.
        var transactionDetails = event;
        print('event: ${transactionDetails}');
        AppHelper.showToast(message: 'event; failed transaction ${transactionDetails}'.tr, color: Colors.redAccent);

      }
      update();
    });
    // .then((value) {
    //   print('startApplePayment: ${jsonEncode(value)}');
    // }).catch((err) {
    //       print('catched error: ${jsonEncode(value)}')
    //       AppHelper.showToast(message: 'catched error: ${jsonEncode(value)}', color: Colors.redAccent);

    // })
  }

  void payment({required int packageId}) {
    ApiRequests.payment(
        token: AppHelper.getCurrentUserToken(),
        packageId: packageId,
        paymentId: 1)
        .then((value) {
      if (value != null) {
        paymentData = value;
        launchUrl(Uri.parse(paymentData.url!), mode: LaunchMode.inAppWebView);
        // print('LINK payment: ${paymentData.url}');
      }
    });
  }

}