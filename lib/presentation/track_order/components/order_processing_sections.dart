import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/app.colors.dart';

class OrderProcessingSections extends StatelessWidget {
  const OrderProcessingSections({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'status': 'Order Confirmed', 'isCompleted': true, 'time': '10:30 AM'},
      {'status': 'Preparing', 'isCompleted': true, 'time': '10:45 AM'},
      {
        'status': 'On the way',
        'isCompleted': true,
        'time': '11:15 AM',
        'isCurrent': true
      },
      {
        'status': 'Delivered',
        'isCompleted': false,
        'time': 'Estimated 11:45 AM'
      },
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++)
            _buildTimelineStep(
              status: steps[i]['status'] as String,
              time: steps[i]['time'] as String,
              isCompleted: steps[i]['isCompleted'] as bool,
              isCurrent: steps[i]['isCurrent'] == true,
              isLast: i == steps.length - 1,
            ),
        ],
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DottedLine({
    super.key,
    this.height = 40,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(2, height),
      painter: _DottedLinePainter(color),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  _DottedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    const double dashHeight = 4;
    const double dashSpacing = 4;

    double startY = 0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.round;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _buildTimelineStep extends StatelessWidget {
  final String status;
  final String time;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  const _buildTimelineStep({
    super.key,
    required this.status,
    required this.time,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.light.primaryColor
                    : (isCurrent
                        ? AppColors.light.primaryColor.withOpacity(0.2)
                        : Colors.grey[300]),
                border: isCurrent
                    ? Border.all(color: AppColors.light.primaryColor, width: 2)
                    : null,
              ),
            ),
            if (!isLast)
              DottedLine(
                //width: 2,
                height: isCurrent ? 40 : 25,
                color: isCompleted
                    ? AppColors.light.primaryColor
                    : Colors.grey[300]!,
              ),
          ],
        ),
        const SizedBox(width: 12),
        // Status and time
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                if (isCurrent)
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          fontFamily: GoogleFonts.manrope().fontFamily,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
