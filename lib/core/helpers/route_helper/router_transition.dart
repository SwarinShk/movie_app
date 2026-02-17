// Example transitions
import 'package:flutter/material.dart';

Widget fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}

Widget slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(1.0, 0.0); // Slide from right
  const end = Offset.zero;
  final tween = Tween(
    begin: begin,
    end: end,
  ).chain(CurveTween(curve: Curves.easeInOut));
  return SlideTransition(position: animation.drive(tween), child: child);
}
