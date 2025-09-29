import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/app.assets.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height,
      decoration: BoxDecoration(
        image:DecorationImage(
          image: AssetImage(AppAssets.light.icons.splashScreen),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
