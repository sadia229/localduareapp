import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/search.controller.dart';

class SearchScreen extends GetView<RestaurantsSearchController> {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SearchScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
