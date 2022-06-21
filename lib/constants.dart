import 'package:flutter/material.dart';

final primaryColor = Colors.purple;
final secondaryColor = Colors.amber;

var primaryGradint =
    LinearGradient(colors: [primaryColor.withOpacity(0.8), primaryColor]);

var secondaryGradint =
    LinearGradient(colors: [secondaryColor.withOpacity(0.8), secondaryColor]);

const kDefaultPadding = 16.0;

abstract class Fonts {
  static const Regular = "Regular";
  static const Medium = "Medium";
  static const Bold = "Bold";
  static const Black = "Black";
}