import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/navigation/routes.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../infrastructure/theme/app.colors.dart';
import 'controllers/profile.controller.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String? balance;
  final bool? showBalance;
  final VoidCallback onTap;

  const ProfileMenuItem({
    Key? key,
    required this.title,
    this.balance,
    this.showBalance = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                  ),
            ),
            if (showBalance == true)
              Text(
                balance ?? "",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      color: AppColors.light.buttonGradient1,
                    ),
              ),
            if (showBalance == false)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: Get.height * 0.12,
                padding: const EdgeInsets.only(top: 24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.light.buttonBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Image.asset(
                          "assets/images/arrow_left_alt.png",
                          height: 24.0,
                        ),
                      ),
                    ),
                    Text(
                      "Account",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            // Menu Items
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ProfileMenuItem(
                    title: 'My Balance`',
                    onTap: () {},
                    balance: 'BDT 5,000',
                    showBalance: true,
                  ),
                  ProfileMenuItem(
                    title: 'Delivery Address',
                    onTap: () {
                      Get.toNamed(Routes.GET_DELIVERY_ADDRESS);
                      // Get.toNamed(Routes.PROFILE_ADD_ADDRESS);
                    },
                  ),
                  ProfileMenuItem(
                    title: 'Order On Whatsapp',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    title: 'Log in / Sign out',
                    onTap: () {},
                  ),
                  // ProfileMenuItem(
                  //   title: 'Terms & Conditions',
                  //   onTap: () {},
                  // ),
                  // ProfileMenuItem(
                  //   title: 'Privacy Policy',
                  //   onTap: () {},
                  // ),
                  // ProfileMenuItem(
                  //   title: 'About Us',
                  //   onTap: () {},
                  // ),
                  // ProfileMenuItem(
                  //   title: 'Logout',
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.light.primaryColor,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
