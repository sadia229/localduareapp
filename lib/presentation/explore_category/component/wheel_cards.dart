// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
//
// // ✅ Pentagon Shape
// class PentagonClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final Path path = Path();
//     final double w = size.width;
//     final double h = size.height;
//     final double cx = w / 2;
//     final double cy = h / 2;
//     final double radius = min(w, h) / 2;
//
//     for (int i = 0; i < 5; i++) {
//       double angle = (pi / -2) + (2 * pi * i / 5); // start from top
//       double x = cx + radius * cos(angle);
//       double y = cy + radius * sin(angle);
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(PentagonClipper oldClipper) => false;
// }
//
// // ✅ Pentagon Carousel Widget
// class PentagonCarousel extends StatefulWidget {
//   const PentagonCarousel({super.key});
//
//   @override
//   State<PentagonCarousel> createState() => _PentagonCarouselState();
// }
//
// class _PentagonCarouselState extends State<PentagonCarousel> {
//   final PageController _pageController = PageController(viewportFraction: 0.4);
//   int _currentPage = 0;
//   late Timer _timer;
//
//   final List<Color> colors = [
//     Colors.red,
//     Colors.blue,
//     Colors.green,
//     Colors.orange,
//     Colors.purple,
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (_pageController.hasClients) {
//         _currentPage = (_currentPage + 1) % colors.length;
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 180,
//       child: PageView.builder(
//         controller: _pageController,
//         itemCount: colors.length,
//         itemBuilder: (context, index) {
//           return Transform.scale(
//             scale: index == _currentPage ? 1.1 : 0.9, // zoom effect
//             child: ClipPath(
//               clipper: PentagonClipper(),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 12),
//                 color: colors[index],
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Item ${index + 1}",
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PentagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path = Path();
    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.35);
    path.lineTo(w * 0.8, h);
    path.lineTo(w * 0.2, h);
    path.lineTo(0, h * 0.35);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}