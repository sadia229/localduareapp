import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/app.colors.dart';
import 'controllers/bkash_webview.controller.dart';

class BkashWebviewScreen extends GetView<BkashWebviewController> {
  const BkashWebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          debugPrint("hitBackButton");
          Get.back();
          return false;
        },
        child: Obx(
          () => Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Get.height,
                      child: InAppWebView(
                        key: controller.webViewKey,
                        // gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                        gestureRecognizers: <Factory<
                            OneSequenceGestureRecognizer>>{
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        },
                        initialUrlRequest:
                            URLRequest(url: WebUri(controller.url.value)),
                        onWebViewCreated:
                            (InAppWebViewController inAppcCntroller) {
                          controller.webViewController = inAppcCntroller;
                        },
                        onProgressChanged:
                            (InAppWebViewController inAppcCntroller,
                                int progress) async {
                          controller.loadingPercentage.value = progress;
                          debugPrint(
                              'appx onProgressChanged: ${controller.loadingPercentage.value}');

                          if (progress == 100) {
                            String? currentUrl =
                                (await inAppcCntroller.getUrl())?.toString();
                            debugPrint('appx currentUrl: $currentUrl');

                            if (currentUrl != null &&
                                (currentUrl.contains("SUCCESS") ||
                                    currentUrl.contains("SUCCEEDED") ||
                                    currentUrl.contains("medha.com.bd"))) {
                              print("appx finish - navigating back");
                              inAppcCntroller.clearCache();
                              Get.toNamed(Routes.ORDER_PLACE_SUCCESS);
                            }
                          }
                        },
                        onCloseWindow:
                            (InAppWebViewController inAppcCntroller) {
                          inAppcCntroller.clearCache();
                          Get.back();
                        },
                        onLoadStart:
                            (InAppWebViewController inAppcCntroller, Uri? uri) {
                          debugPrint("onLoadStart: $uri");
                        },
                        onLoadStop:
                            (InAppWebViewController inAppcCntroller, Uri? uri) {
                          //check if url contains 'FAILED' or 'SUCCESS' or 'SUCCEEDED'
                          if (uri.toString().contains('FAILED') ||
                              uri.toString().contains('SUCCESS') ||
                              uri.toString().contains('SUCCEEDED')) {
                            inAppcCntroller.clearCache();
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (controller.loadingPercentage.value < 100)
                LinearProgressIndicator(
                  color: AppColors.light.primaryColor,
                  backgroundColor: Colors.transparent,
                  value: controller.loadingPercentage.value / 100.0,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
  //nested scrolling gesture recognizer
  Factory<VerticalDragGestureRecognizer>(
    () => VerticalDragGestureRecognizer(),
  ),
};
