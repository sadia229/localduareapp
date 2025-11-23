import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/order_history_details_status.controller.dart';

class OrderHistoryDetailsStatusScreen
    extends GetView<OrderHistoryDetailsStatusController> {
  const OrderHistoryDetailsStatusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderHistoryDetailsStatusScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrderHistoryDetailsStatusScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
