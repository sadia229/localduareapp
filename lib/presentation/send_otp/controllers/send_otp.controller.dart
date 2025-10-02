import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/data/model/otp_model.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/static/project.constants.dart';

class SendOtpController extends GetxController {
  final otpCode = "".obs;
  final otpController = TextEditingController();
  final phoneNumber = "".obs;
  final _isOtpLoading = false.obs;

  bool get isOtpLoading => _isOtpLoading.value;
  final _otpResponse = Rxn<OtpModel>();

  OtpModel? get otpResponse => _otpResponse.value;

  @override
  void onInit() {
    super.onInit();
    phoneNumber.value = Get.arguments["phoneNumber"];
    debugPrint("print phone number:${phoneNumber.value}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> verifyOtp() async {
    try {
      _isOtpLoading.value = true;
      var body = json.encode({
        'phone': phoneNumber.value,
        'otp': otpController.text,
      });
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-otp'),
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final responseBody = json.decode(response.body);
      _otpResponse.value = OtpModel.fromJson(responseBody);
      prefs.setString('token', otpResponse?.data?.accessToken ?? '');
      _isOtpLoading.value = false;
      if (response.statusCode == 200) {
        Get.snackbar("Success", otpResponse?.message ?? '' ?? "OTP sent");
        Get.toNamed(Routes.EXPLORE_CATEGORY);
      }
    } catch (e) {
      _isOtpLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
