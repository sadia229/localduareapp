import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localduareapp/presentation/shared/common/app.background.dart';

import 'controllers/coming_soon.controller.dart';

class ComingSoonScreen extends GetView<ComingSoonController> {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/images/comming-soon.png',
                height: Get.height * 0.35,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "Coming Soon.....",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      color: Colors.blue.shade800,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
