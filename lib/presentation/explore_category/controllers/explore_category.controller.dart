import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class ExploreCategoryController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // full opacity
      random.nextInt(256), // red 0-255
      random.nextInt(256), // green 0-255
      random.nextInt(256), // blue 0-255
    );
  }
}




