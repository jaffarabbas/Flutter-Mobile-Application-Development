// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = CarouselController();
  int activeState = 0;
  final UrlImages = [
    "assets/Images/roundImg1.png",
    "assets/Images/roundImage2.png",
    "assets/Images/roundImage3.png",
    "assets/Images/pizza.jpg",
    "assets/Images/japanese-restaurant.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Carosel'),
        ),
        body: Center(
          child: Container(
            child: Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: UrlImages.length,
                  options: CarouselOptions(
                      height: 400,
                      enlargeCenterPage: true,
                      viewportFraction: .45,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      initialPage:0),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = UrlImages[index];
                    return buildImage(urlImage, index);
                  },
                ),
                Positioned(
                  top: 200,
                  right: 55,
                  child: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: previos,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.red,
                            )),
                        ElevatedButton(
                            onPressed: next,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.all(10),
       // color: Colors.grey,
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage(urlImage),
        ),
      );

  // Widget buildButton() => Expanded(
  //   child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           ElevatedButton(
  //               onPressed: previos,
  //               child: Icon(
  //                 Icons.arrow_back_ios,
  //                 color: Colors.red,
  //               )),
  //           ElevatedButton(
  //               onPressed: next,
  //               child: Icon(
  //                 Icons.arrow_forward_ios,
  //                 color: Colors.red,
  //               ))
  //         ],
  //       ),
  // );

  void next() => controller.nextPage();
  void previos() => controller.previousPage();
}
