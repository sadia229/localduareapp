import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontFamily: GoogleFonts.manrope().fontFamily,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
    );
  }
}
