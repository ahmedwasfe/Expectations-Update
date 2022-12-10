import 'dart:io';

import 'package:expectations/utils/app_helper.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesApi{

  // TODO APPLE KEY -> appl_CGYDNAAXaglTwpaxkoqpXcrBQFc
  // TODO ANDROID KEY -> goog_DRMQGvKZoeDdIfRiDXaidsuYcSA
  static const String _iosKey = 'appl_CGYDNAAXaglTwpaxkoqpXcrBQFc';
  static const String _androidKey = 'goog_DRMQGvKZoeDdIfRiDXaidsuYcSA';
  static String _apiKey = Platform.isAndroid ? _androidKey : _iosKey;

  static Future initPurchases() async {
    final _config = PurchasesConfiguration(_apiKey)/*..appUserID = AppHelper.getUserId() != null ? '${AppHelper.getUserId()}' : '0'*/;
    await Purchases.setDebugLogsEnabled(false);
    await Purchases.configure(_config);
    // Purchases.logIn(AppHelper.getUserId() != null ? AppHelper.getUserId().toString() : '0');
    // Purchases.logOut();
    print('KEY initPurchases: $_apiKey');
  }

  static Future<List<Offering>> fetchOfferes() async {
    try{
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      return current == null ? [] : [current];
    } on PlatformException catch(e){
      print('fetchOfferes: ${e.toString()}');
      return [];
    }
  }

  static Future<bool> purchaesPackage(Package package) async {
    try{
      await Purchases.purchasePackage(package);
      return true;
    }catch(e) {
      print('purchaesPackage: ${e.toString()}');
      return false;
    }
  }

  static Future<bool> purchaesProduct(String product) async {
    try{
      await Purchases.purchaseProduct(product);
      return true;
    }catch(e) {
      print('purchaesProduct: ${e.toString()}');
      return false;
    }
  }
}