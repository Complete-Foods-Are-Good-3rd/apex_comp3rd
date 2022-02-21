import 'package:flutter/material.dart';

final List<Color> colorList = [const Color(0xFFFFFFFF), const Color(0xFF000000), const Color(0xFF0000FF), const Color(0xFFFF00FF),
  const Color(0xFFFFFF00), const Color(0xFF00FFFF), const Color(0xFFFF0000), const Color(0xFF00FF00)];
final List<String> colorNames = ['White', 'Black', 'Blue', 'Magenta', 'Yellow', 'Cyan', 'Red', 'Green'];
final List<Image> imageList = [
  Image.asset(
    'assets/counter_0.png',
    fit: BoxFit.contain,
  ),
  Image.asset(
    'assets/counter_1.png',
    fit: BoxFit.contain,
  ),
  // Image.asset(
  //   'assets/ring.png',
  //   fit: BoxFit.contain,
  // ),
  // Image.asset(
  //   'assets/ring.png',
  //   fit: BoxFit.contain,
  // ),
  // Image.asset(
  //   'assets/ring.png',
  //   fit: BoxFit.contain,
  // ),
];
