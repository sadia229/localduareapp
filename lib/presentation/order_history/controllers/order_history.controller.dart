import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../infrastructure/data/model/order_history_model.dart';
import '../../../infrastructure/static/project.constants.dart';

class OrderHistoryController extends GetxController {
  final count = 0.obs;
  final isLoading = false.obs;
  final orderHistoryList = Rxn<OrderHistoryModel>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await _fetchOrderHistory();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> _fetchOrderHistory() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/my-orders'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final responseBody = json.decode(response.body);
      isLoading.value = false;
      if (response.statusCode == 200) {
        orderHistoryList.value = OrderHistoryModel.fromJson(responseBody);
        debugPrint("Order History Response: ${orderHistoryList.value?.toJson()}");
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
