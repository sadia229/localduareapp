import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class BkashWebviewController extends GetxController {
  UniqueKey webViewKey = UniqueKey();
  final loadingPercentage = 0.obs;
  late InAppWebViewController webViewController;
  final url = "".obs;

  @override
  void onInit() {
    url.value = Get.arguments['url'] ?? "";
    super.onInit();
  }
}
