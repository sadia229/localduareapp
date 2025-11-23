
import 'package:get/get.dart';
import 'package:localduareapp/presentation/add_address/controllers/add_address.controller.dart';
import 'package:localduareapp/presentation/cart/controllers/cart.controller.dart';
import 'package:localduareapp/presentation/checkout/controllers/checkout.controller.dart';
import 'package:localduareapp/presentation/shop_details/controllers/shop_details.controller.dart';
import 'package:localduareapp/presentation/shop_menu/controllers/shop_menu.controller.dart';
import '../../../../presentation/explore_category/controllers/explore_category.controller.dart';
import '../../../../presentation/home/controllers/home.controller.dart';
import '../../../../presentation/order_history/controllers/order_history.controller.dart';
import '../../../../presentation/select_address/controllers/select_address.controller.dart';
import '../../../../presentation/select_phone_number/controllers/select_phone_number.controller.dart';
import '../../../../presentation/send_otp/controllers/send_otp.controller.dart';
import '../../../../presentation/splash/controllers/splash.controller.dart';

class DomainLayerDependencyInjectionContainer {
  static Future<void> init() async {
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<ExploreCategoryController>(() => ExploreCategoryController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SelectAddressController>(() => SelectAddressController(), fenix: true);
    Get.lazyPut<SelectPhoneNumberController>(() => SelectPhoneNumberController(), fenix: true);
    Get.lazyPut<SendOtpController>(() => SendOtpController(), fenix: true);
    Get.lazyPut<AddAddressController>(() => AddAddressController(), fenix: true);
    Get.lazyPut<ShopDetailsController>(() => ShopDetailsController(), fenix: true);
    Get.lazyPut<ShopMenuController>(() => ShopMenuController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<CheckoutController>(() => CheckoutController(), fenix: true);
    Get.lazyPut<OrderHistoryController>(() => OrderHistoryController(), fenix: true);
  }
}
