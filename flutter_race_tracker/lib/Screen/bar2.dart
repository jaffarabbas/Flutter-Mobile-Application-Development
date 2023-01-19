import 'package:flutter/material.dart';

class LinearSlider extends StatefulWidget {
  @override
  _LinearSliderState createState() => _LinearSliderState();
}

class _LinearSliderState extends State<LinearSlider> {
  double sliderValue = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Slider(
            value: sliderValue,
            onChanged: (v) {
              setState(() {
                sliderValue = v;
              });
            },
          ),
          LinearProgressIndicator(
            value: sliderValue,
          ),
        ],
      ),
    );
  }
}
