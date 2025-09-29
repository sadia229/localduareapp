import 'package:get/get.dart';

import '../../../../presentation/explore_category/controllers/explore_category.controller.dart';

class ExploreCategoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreCategoryController>(
      () => ExploreCategoryController(),
    );
  }
}
