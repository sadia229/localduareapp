import 'package:get/get.dart';

import '../../../../presentation/bkash_webview/controllers/bkash_webview.controller.dart';

class BkashWebviewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BkashWebviewController>(
      () => BkashWebviewController(),
    );
  }
}
