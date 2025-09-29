
import 'package:get/get.dart';
import '../../../../presentation/explore_category/controllers/explore_category.controller.dart';
import '../../../../presentation/home/controllers/home.controller.dart';
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
  }
}
