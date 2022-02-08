import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return _file.readAsBytes();
  }
  print('No image');
}

ShowSnakBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void NavigatorToScreen(BuildContext context, Widget widget, int methodNumber) {
  if (methodNumber == 0) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  } else if (methodNumber == 1) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }
}
