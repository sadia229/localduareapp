import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/add_address.controller.dart';

class AddAddressScreen extends GetView<AddAddressController> {
  const AddAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddAddressScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddAddressScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
