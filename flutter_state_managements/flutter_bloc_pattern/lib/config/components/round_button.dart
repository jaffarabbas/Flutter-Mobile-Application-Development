import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/color/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback pressHandler;
  const RoundButton(
      {super.key, required this.title, required this.pressHandler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressHandler,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: AppColor.buttonColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child:
              Text(style: const TextStyle(color: AppColor.whiteColor), title),
        ),
      ),
    );
  }
}
