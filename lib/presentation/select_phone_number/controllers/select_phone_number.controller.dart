import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/static/project.constants.dart';

class SelectPhoneNumberController extends GetxController {
  final phoneNumberTextController = TextEditingController();
  final phoneNumber = ''.obs;
  final phoneNumberError = ''.obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  String validatePhoneNumber(String value) {
    phoneNumber.value = value;
    if (value.isEmpty) {
      phoneNumberError.value = 'Please enter your phone number';
    } else if (!value.startsWith('01')) {
      phoneNumberError.value = 'Phone number must start with 01';
    } else if (value.length != 11) {
      phoneNumberError.value = 'Phone number must be 11 digits';
    } else {
      phoneNumberError.value = '';
    }
    return '';
  }

  Future<void> sendPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final franchiseId = prefs.getString('franchiseId');
    try {
      _isLoading.value = true;
      var body = json.encode({
        'phone': phoneNumberTextController.text,
        'franchiseId': franchiseId,
      });
      final response = await http.post(
        Uri.parse('$baseUrl/auth/send-otp'),
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
      final responseBody = json.decode(response.body);
      _isLoading.value = false;
      if (response.statusCode == 200) {
        Get.snackbar("Success", responseBody["message"] ?? "OTP sent");
        Get.toNamed(
          Routes.SEND_OTP,
          arguments: {"phoneNumber": phoneNumberTextController.text},
        );
      }
    } catch (e) {
      _isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
