import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../infrastructure/data/model/otp_model.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/static/project.constants.dart';

class SendOtpController extends GetxController with CodeAutoFill {
  final otpController = TextEditingController();
  final phoneNumber = "".obs;
  final _isOtpLoading = false.obs;
  final _otpResponse = Rxn<OtpModel>();

  // prevent multiple auto-submits when both sms_autofill and onCodeChanged fire
  bool _hasAutoSubmitted = false;

  bool get isOtpLoading => _isOtpLoading.value;

  OtpModel? get otpResponse => _otpResponse.value;

  @override
  void onInit() {
    super.onInit();
    phoneNumber.value = Get.arguments?["phoneNumber"] ?? '';
    debugPrint('SendOtpController: phoneNumber=${phoneNumber.value}');
    // start listening for the SMS code
    listenForCode();
    _printAppSignature();
    SmsAutoFill().listenForCode();
  }

  Future<void> _printAppSignature() async {
    try {
      final signature = await SmsAutoFill().getAppSignature;
      debugPrint('APP SIGNATURE (hash): $signature');
      // send this to backend or log it so you can append it to SMS during testing
    } catch (e) {
      debugPrint('Error getting app signature: $e');
    }
  }

  /// Called by CodeAutoFill mixin when code arrives
  @override
  void codeUpdated() {
    final incoming = code;
    debugPrint('codeUpdated fired -> $incoming');
    if (incoming != null && incoming.isNotEmpty) {
      // set the text (PinFieldAutoFill also sets it, but set here to be safe)
      otpController.text = incoming;
      _tryAutoSubmit(incoming);
    }
  }

  void onPinFieldChanged(String? code) {
    debugPrint('onPinFieldChanged -> $code');
    if (code != null && code.length == 6) {
      _tryAutoSubmit(code);
    }
  }

  // Internal: attempt auto-submit only once per code
  void _tryAutoSubmit(String code) {
    if (_hasAutoSubmitted) {
      debugPrint('Already auto-submitted, skipping.');
      return;
    }
    _hasAutoSubmitted = true;
    // small delay to let UI update and spinner appear smoothly
    Future.delayed(const Duration(milliseconds: 150), () {
      verifyOtp();
    });
  }

  /// Call to resend OTP (implement your backend call here)
  Future<void> resendOtp() async {
    try {
      // set loading if you want UI feedback
      _isOtpLoading.value = true;
      // TODO: call your resend endpoint. Example skeleton:
      // final response = await http.post(Uri.parse('$baseUrl/auth/resend-otp'), body: { 'phone': phoneNumber.value });
      await Future.delayed(const Duration(milliseconds: 800)); // placeholder
      Get.snackbar('OTP', 'OTP resent to ${phoneNumber.value}');
    } catch (e) {
      debugPrint('resendOtp error: $e');
      Get.snackbar('Error', 'Could not resend OTP');
    } finally {
      _isOtpLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // stop listening for SMS and dispose controller
    try {
      cancel(); // from CodeAutoFill
    } catch (e) {
      debugPrint('cancel listen error: $e');
    }
    otpController.dispose();
    super.onClose();
  }

  Future<void> verifyOtp() async {
    try {
      _isOtpLoading.value = true;

      final body = json.encode({
        'phone': phoneNumber.value,
        'otp': otpController.text,
      });

      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      final responseBody = json.decode(response.body);
      _otpResponse.value = OtpModel.fromJson(responseBody);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', otpResponse?.data?.accessToken ?? '');
        Get.snackbar("Success", otpResponse?.message ?? "OTP verified");
        Get.toNamed(Routes.SELECT_ADDRESS);
      } else {
        // handle non-200 with message from response if available
        Get.snackbar("Error", _otpResponse.value?.message ?? "Invalid OTP");
      }
    } catch (e) {
      debugPrint('verifyOtp error: $e');
      Get.snackbar("Error", "Something went wrong");
    } finally {
      _isOtpLoading.value = false;
    }
  }
}
