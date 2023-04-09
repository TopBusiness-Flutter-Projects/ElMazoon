import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.2913691);
    path_0.cubicTo(
        size.width,
        size.height * 0.4984757,
        size.width * 0.9350636,
        size.height * 0.6663684,
        size.width * 0.8549618,
        size.height * 0.6663684);
    path_0.lineTo(size.width * 0.1394687, size.height * 0.6663684);
    path_0.cubicTo(
        size.width * 0.08877913,
        size.height * 0.6663684,
        size.width * 0.04292595,
        size.height * 0.7441645,
        size.width * 0.02275219,
        size.height * 0.8644013);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff4455D7).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
