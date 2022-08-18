import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mvvm_architecture/res/colors.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;
  const DefaultButton({Key? key, required this.title, this.loading = false, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.primaryColor,
        ),
        child: loading ? CircularProgressIndicator(color: Colors.white,) : Text(
          title,
          style: TextStyle(
            color: AppColor.secondaryTextColor,
          ),
        ),
      ),
    );
  }
}
