import 'dart:io';

import 'package:expectations/api/purchases_api.dart';
import 'package:expectations/controllers/language_controller.dart';
import 'package:expectations/routes/routes.dart';
import 'package:expectations/shared/style/theme.dart';
import 'package:expectations/utils/app_helper.dart';
import 'package:expectations/utils/bindings/app_bindings.dart';
import 'package:firebase_core/firebase_core.dart';

// show Firebase, FirebaseOptions;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:purchases_flutter/models/purchases_configuration.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'utils/local/local.dart';
 
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initServices();
  await PurchasesApi.initPurchases();
  // ApiRequests.initAPI();
  runApp(MyApp());
}

Future initServices() async {
  await Get.putAsync(() => AppHelper().initial());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LanguageController controller = Get.put(LanguageController());
    print("LANG: ${controller.getAppLocale()}");
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: controller.getAppLocale(),
        translations: MyLocal(),
        initialRoute: Routes.splash,
        initialBinding: AppBindings(),
        theme: appTheme(),
        getPages: AppRoutes.routesPages,
      )
    );
  }
}