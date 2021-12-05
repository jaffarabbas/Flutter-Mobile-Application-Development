// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Resposive {
  static double ResposiveHeight(BuildContext context, double height) {
    return ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight) * height);
  }

  static double ResponsiveWidth(BuildContext context, double width) {
    return (MediaQuery.of(context).size.width * width);
  }
}