import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/infrastructure/theme/app.colors.dart';

import '../shared/common/app.background.dart';
import 'controllers/leadboard.controller.dart';

final List<String> leaderboardCategoryItems = [
  'Restaurants',
  'Food & Beverage',
  'Grocery',
  'Electronics',
  'Fashion'
];

class PlayerCard extends StatelessWidget {
  final String playerId;
  final String playerName;
  final String imageUrl;
  final int totalOrders;
  final int rank;

  const PlayerCard({
    Key? key,
    required this.playerId,
    required this.playerName,
    required this.imageUrl,
    required this.totalOrders,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _getRankColor(rank),
              shape: BoxShape.circle,
            ),
            child: Text(
              '#$rank',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Player Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl),
            onBackgroundImageError: (exception, stackTrace) {
              // Handle image loading error
            },
            child: imageUrl.isEmpty
                ? const Icon(Icons.person, size: 24, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          // Player Info
          Expanded(
            child: Text(
              playerName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Total Orders
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total Orders',
                style: TextStyle(
                  color: AppColors.light.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                totalOrders.toString(),
                style: TextStyle(
                  color: AppColors.light.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return AppColors.light.primaryColor;
    }
  }
}

class LeadboardScreen extends GetView<LeadboardController> {
  const LeadboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Category",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                    color: Colors.black,
                                  ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: leaderboardCategoryItems.first,
                                isExpanded: false,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded),
                                items:
                                    leaderboardCategoryItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontFamily: GoogleFonts.manrope()
                                                .fontFamily,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    // Handle category change
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Image.asset(
                            "assets/images/Bag 4.png",
                            height: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      Text(
                        "Leaderboard",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Spacer(),
                      Icon(Icons.info_outline),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Container(
                  height: Get.height * 0.22,
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 12.0),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.light.buttonGradient1,
                        AppColors.light.buttonGradient2,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.lightBlue,
                          ),
                          Positioned(
                            bottom: -8,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.purpleAccent,
                                child: Center(
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -Get.height * 0.04,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: Get.width * 0.6,
                                child: Text(
                                  "John Dow",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.lightBlue,
                          ),
                          Positioned(
                            top: -16,
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              "assets/images/crown.png",
                              height: 26.0,
                            ),
                          ),
                          Positioned(
                            bottom: -8,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.amber.shade700,
                                child: Center(
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -Get.height * 0.04,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: Get.width * 0.6,
                                child: Text(
                                  "John Dow",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.lightBlue,
                          ),
                          Positioned(
                            bottom: -8,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.lightBlue.shade700,
                                child: Center(
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -Get.height * 0.04,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: Get.width * 0.6,
                                child: Text(
                                  "John Dow",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 16)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final players = [
                      {'name': 'Alex Johnson', 'id': 'P1001', 'orders': 245, 'image': 'https://randomuser.me/api/portraits/men/1.jpg'},
                      {'name': 'Sarah Williams', 'id': 'P1002', 'orders': 198, 'image': 'https://randomuser.me/api/portraits/women/1.jpg'},
                      {'name': 'Michael Brown', 'id': 'P1003', 'orders': 187, 'image': 'https://randomuser.me/api/portraits/men/2.jpg'},
                      {'name': 'Emily Davis', 'id': 'P1004', 'orders': 165, 'image': 'https://randomuser.me/api/portraits/women/2.jpg'},
                      {'name': 'David Wilson', 'id': 'P1005', 'orders': 142, 'image': 'https://randomuser.me/api/portraits/men/3.jpg'},
                    ];
                    
                    if (index >= players.length) return null;
                    
                    return PlayerCard(
                      rank: index + 1,
                      playerId: players[index]['id'] as String,
                      playerName: players[index]['name'] as String,
                      imageUrl: players[index]['image'] as String,
                      totalOrders: players[index]['orders'] as int,
                    );
                  },
                  childCount: 2,
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
