import 'package:flutter/material.dart';

///Padding
extension PaddingExtension on Widget {

  ///add uniform padding around the widget
  Widget padAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  ///add vertical and horizontal padding to the widget
  Widget padSymmetric({double vertical = 0.0, double horizontal = 0.0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal));
}


///Border
extension BorderExtension on Widget {
  Widget withBorder({Color color = Colors.black, double width = 1.0}) =>
      Container(
        decoration:
            BoxDecoration(border: Border.all(color: color, width: width)),
        child: this,
      );
}
