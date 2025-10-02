import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/get_delivery_address.controller.dart';

class GetDeliveryAddressScreen extends GetView<GetDeliveryAddressController> {
  const GetDeliveryAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetDeliveryAddressScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GetDeliveryAddressScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
