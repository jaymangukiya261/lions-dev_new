import 'package:flutter/material.dart';

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    /*final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, 0);
    */
    var controlPoint = Offset(size.width / 2, size.height / 2);
    var endPoint = Offset(size.width, size.height);

    final Path path = new Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..lineTo(0, size.height)
      ..quadraticBezierTo(controlPoint.dx, size.height + controlPoint.dy,
          endPoint.dx, endPoint.dy)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
