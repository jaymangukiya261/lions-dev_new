import 'package:flutter/material.dart';

class ArcWidget extends CustomPainter {
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
    canvas.drawCircle(Offset(size.width / 2, size.height - 450), 450, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
