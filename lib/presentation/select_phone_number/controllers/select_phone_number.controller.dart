import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPhoneNumberController extends GetxController {
  final phoneNumberTextController = TextEditingController();
  final phoneNumber = ''.obs;
  final phoneNumberError = ''.obs;

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
}
