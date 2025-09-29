import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../shared/common/app.background.dart';
import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        controller.count.value;
        return AppBackground(
          child: Center(
            child: Image.asset(
              "assets/logo/logo.png",
              height: 64,
            ),
          ),
        );
      }),
    );
  }
}
