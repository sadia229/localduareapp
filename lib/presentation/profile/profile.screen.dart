import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../infrastructure/theme/app.colors.dart';
import 'controllers/profile.controller.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            decoration: BoxDecoration(
              color: AppColors.light.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.light.primaryColor, size: 22),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, 
              size: 16, 
              color: Colors.grey[400]
          ),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        if (showDivider)
          const Divider(height: 1, indent: 16, endIndent: 16, thickness: 0.5),
      ],
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
                margin: const EdgeInsets.only(top: 24.0),
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
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'My Addresses',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.credit_card_outlined,
                      title: 'Payment Methods',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'My Wishlist',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            
            // Support Section
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.info_outline_rounded,
                      title: 'About Us',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            
            // App Version
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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
