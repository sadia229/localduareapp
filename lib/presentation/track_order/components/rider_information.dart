
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/app.colors.dart';
class RiderInformation extends StatelessWidget {
  const RiderInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Rider Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.light.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delivery_dining_rounded,
                  size: 32,
                  color: AppColors.light.primaryColor,
                ),
              ),
              const SizedBox(width: 16),

              // Rider Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rider',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontFamily: GoogleFonts.manrope().fontFamily,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "name",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Call Button
              IconButton(
                onPressed: () {

                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.light.primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  Icons.phone_rounded,
                  color: AppColors.light.primaryColor,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.grey[600],
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Estimated time",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "30mins",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                  fontFamily: GoogleFonts.manrope().fontFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey[600],
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Deliver to",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                      fontFamily: GoogleFonts.manrope().fontFamily,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "Home",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                  fontFamily: GoogleFonts.manrope().fontFamily,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
