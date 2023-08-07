import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color(0xffBBF0BC)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0, size.height * 0);
    path_0.lineTo(size.width * 0, size.height * 0.9285714);
    path_0.lineTo(size.width * 0.2086667, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.2921667, size.height * 0.8571429);
    path_0.lineTo(size.width * 0.3751667, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.4173333, size.height * 0.9291429);
    path_0.lineTo(size.width * 0.5007250, size.height * 0.8576143);
    path_0.lineTo(size.width * 0.5833333, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.6253333, size.height * 0.9294286);
    path_0.lineTo(size.width * 0.7085000, size.height * 0.8520000);
    path_0.lineTo(size.width * 0.7921667, size.height * 0.9288571);
    path_0.lineTo(size.width * 1, size.height * 0.9285714);
    path_0.lineTo(size.width * 1, size.height * 0);

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 187, 240, 188)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
