import 'package:flutter/material.dart';
import 'dart:ui';

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Color color;
  final double borderRadius;
  final List<double> dashPattern;

  const DashedBorder({
    Key? key,
    required this.child,
    this.strokeWidth = 2,
    this.color = Colors.grey,
    this.borderRadius = 0,
    this.dashPattern = const [5, 5],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        strokeWidth: strokeWidth,
        color: color,
        borderRadius: borderRadius,
        dashPattern: dashPattern,
      ),
      child: child,
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double borderRadius;
  final List<double> dashPattern;

  DashedBorderPainter({
    required this.strokeWidth,
    required this.color,
    required this.borderRadius,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(borderRadius),
        ),
      );

    final Path dashedPath = Path();
    const double dashLength = 6;
    const double dashGap = 3;

    for (PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double len = draw ? dashLength : dashGap;
        if (distance + len > metric.length) {
          dashedPath.addPath(
            metric.extractPath(distance, metric.length),
            Offset.zero,
          );
          distance = metric.length;
        } else {
          dashedPath.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
          distance += len;
        }
        draw = !draw;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.dashPattern != dashPattern;
  }
}
