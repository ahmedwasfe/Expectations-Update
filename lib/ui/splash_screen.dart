import 'package:expectations/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          width: 250,
          height: 250,
          'assets/icons/logo5.png',
          //  height: size.height / 4,
        ),
      ),
    );
  }
}
