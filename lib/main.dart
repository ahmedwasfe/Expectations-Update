import 'dart:io';

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
import 'package:permission_handler/permission_handler.dart';

import 'utils/local/local.dart';
 
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   await Firebase.initializeApp();
  await initServices();
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

