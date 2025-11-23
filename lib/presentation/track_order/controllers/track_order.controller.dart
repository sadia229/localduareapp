import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/data/model/track_order_model.dart';
import '../../../infrastructure/static/project.constants.dart';

class TrackOrderController extends GetxController {
  final orderId = "".obs;
  final paymentMethod = "".obs;
  final paymentStatus = "".obs;
  final status = "".obs;
  final isLoading = false.obs;
  final trackOrders = Rxn<TrackOrderModel>();

  @override
  Future<void> onInit() async {
    orderId.value = Get.arguments['orderId'] ?? "";
    paymentMethod.value = Get.arguments['payment_method'] ?? "";
    paymentStatus.value = Get.arguments['payment_status'] ?? "";
    status.value = Get.arguments['status'] ?? "";
    super.onInit();
    await _fetchTrackOrder();
  }

  Future<void> _fetchTrackOrder() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/orders/my-orders?page=1&limit=10&search=${orderId.value}&status=${status.value}&paymentStatus=${paymentStatus.value}&paymentMethod=${paymentMethod.value}&sortBy=createdAt&sortOrder=desc'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final responseBody = json.decode(response.body);
      isLoading.value = false;
      if (response.statusCode == 200) {
        trackOrders.value = TrackOrderModel.fromJson(responseBody);
        debugPrint("Track Order Response: ${trackOrders.value?.toJson()}");
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  String formatOrderDate(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();
    final formatter = DateFormat('dd MMM, hh:mm a');
    return formatter.format(date);
  }
}
