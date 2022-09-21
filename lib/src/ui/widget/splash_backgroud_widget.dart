import 'package:flutter/material.dart';

class SplashBackgroundWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    //draw arc
    /*canvas.drawArc(
        Offset(0, 0) & Size(size.width, size.height),
        0, //radians
        3, //radians
        false,
        paint1);*/

    //canvas.drawLine(Offset(0, 50), Offset(size.width, 250), paint1);
    //
    final Path path = new Path()
      ..lineTo(0, 50)
      ..lineTo(size.width, 250)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
