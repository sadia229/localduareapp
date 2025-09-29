import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.EXPLORE_CATEGORY,
      page: () => const ExploreCategoryScreen(),
      binding: ExploreCategoryControllerBinding(),
    ),
    GetPage(
      name: Routes.GET_STARTED,
      page: () => const GetStartedScreen(),
      binding: GetStartedControllerBinding(),
    ),
    GetPage(
      name: Routes.SELECT_ADDRESS,
      page: () => const SelectAddressScreen(),
      binding: SelectAddressControllerBinding(),
    ),
    GetPage(
      name: Routes.SELECT_PHONE_NUMBER,
      page: () => const SelectPhoneNumberScreen(),
      binding: SelectPhoneNumberControllerBinding(),
    ),
    GetPage(
      name: Routes.SEND_OTP,
      page: () => const SendOtpScreen(),
      binding: SendOtpControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashControllerBinding(),
    ),
    GetPage(
      name: Routes.BOTTOM_NAVBAR,
      page: () => const BottomNavbarScreen(),
      binding: BottomNavbarControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.ORDER_HISTORY,
      page: () => const OrderHistoryScreen(),
      binding: OrderHistoryControllerBinding(),
    ),
    GetPage(
      name: Routes.LEADBOARD,
      page: () => const LeadboardScreen(),
      binding: LeadboardControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileControllerBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartScreen(),
      binding: CartControllerBinding(),
    ),
    GetPage(
      name: Routes.ORDER_HISTORY_PREVIEW,
      page: () => const OrderHistoryPreviewScreen(),
      binding: OrderHistoryPreviewControllerBinding(),
    ),
  ];
}
