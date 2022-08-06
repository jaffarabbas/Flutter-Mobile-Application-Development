import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';

class ConverterLatLang extends StatefulWidget {
  const ConverterLatLang({Key? key}) : super(key: key);

  @override
  State<ConverterLatLang> createState() => _ConverterLatLangState();
}

class _ConverterLatLangState extends State<ConverterLatLang> {
  String finalAddress = '';

  void convertLatLangToAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(24.860966, 66.990501);
    final query = "1600 Amphiteatre Parkway, Mountain View";

    // final cordinates = new Coordinates(24.860966, 66.990501);
    setState(() {
      finalAddress = placemarks.reversed.last.toString();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convert LatLang to Address'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(finalAddress.toString()),
              GestureDetector(
                onTap: () {
                  convertLatLangToAddress();
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Convert',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
