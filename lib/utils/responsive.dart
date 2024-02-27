import 'package:flutter/cupertino.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get pixelHeight => MediaQuery.of(this).size.height / 100;
  double get pixelWidth => MediaQuery.of(this).size.width / 100;

  responsiveWidth(double width) => pixelWidth * (width / resWidth);
  responsiveHeight(double height) => pixelHeight * (height / resHeight);
}

const double resWidth = 3.9272;
const double resHeight = 8.4363;
