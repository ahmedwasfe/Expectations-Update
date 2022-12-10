import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesApi{

  static const _apiKey = 'goog_DRMQGvKZoeDdIfRiDXaidsuYcSA';
  static const _apiKeyApple = 'appl_CGYDNAAXaglTwpaxkoqpXcrBQFc';

  static Future initPurchases() async {
    // final _config = PurchasesConfiguration(_apiKey);
    final _config = PurchasesConfiguration(_apiKeyApple);
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.configure(_config);
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