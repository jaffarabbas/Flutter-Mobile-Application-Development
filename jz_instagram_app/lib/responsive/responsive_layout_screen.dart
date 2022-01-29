// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jz_instagram_app/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;
  const ResponsiveLayout({ Key? key,required this.WebScreenLayout, required this.MobileScreenLayout }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth > webScreenSize){
        //web screen passing
        return WebScreenLayout;
      }
      return MobileScreenLayout;
    });
  }
}