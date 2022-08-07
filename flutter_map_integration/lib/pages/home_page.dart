import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8959986, 67.0300502),
    zoom: 14.4746,
  );

  List<Marker> list = [
    // Marker(
    //     markerId: MarkerId('marker1'),
    //     position: LatLng(24.860966, 66.990501),
    //     infoWindow: InfoWindow(title: 'Marker 1')),
    // Marker(markerId: MarkerId('marker2'),
    //     position: LatLng(24.871940, 66.988060),
    //     infoWindow: InfoWindow(title: 'Marker 2')
    // ),
  ];
  List<Marker> _markers = [];
  List<String> images = [
    "assets/images/car.png",
    "assets/images/food-delivery.png",
    "assets/images/walk.png"
  ];

  List<LatLng> _latLng = [
    LatLng(24.860966, 66.990501),
    LatLng(24.871940, 66.988060),
    LatLng(24.8959986, 67.0300502),
  ];

  void goToHardCodedLocation() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(24.871940, 66.988060), zoom: 24),
      ),
    );
    setState(() {});
  }

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error : ${error.toString()}");
    });
    return await Geolocator.getCurrentPosition();
  }

  void navigateToCurrentLocation() async {
    getCurrentLocation().then((value) async {
      // _markers.add(
      //   Marker(
      //     icon: BitmapDescriptor.fromBytes(markerIcon),
      //     markerId: MarkerId("69"),
      //     position: LatLng(value.latitude, value.longitude),
      //     infoWindow: InfoWindow(
      //         title: 'My location',
      //         snippet: "Lat: ${value.latitude} Long: ${value.longitude}"),
      //   ),
      // );

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  void mapType(String type) async {
    setState(() {
      if (type == "normal") {
        _currentMapType = MapType.normal;
      } else if (type == "satellite") {
        _currentMapType = MapType.satellite;
      } else if (type == "hybrid") {
        _currentMapType = MapType.hybrid;
      } else if (type == "terrain") {
        _currentMapType = MapType.terrain;
      }
    });
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _markers.addAll(list);
    loadData();
    navigateToCurrentLocation();
  }

  void loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLng[i],
          infoWindow: InfoWindow(title: "Marker $i"),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cat Shop',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'open',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'This is a cat shop with it food',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _latLng[i],
            );
          },
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Integration'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(Icons.map, color: Colors.white),
                items: const [
                  DropdownMenuItem(
                    value: 'normal',
                    child: Text('normal'),
                  ),
                  DropdownMenuItem(
                    value: 'satellite',
                    child: Text('Satellite'),
                  ),
                  DropdownMenuItem(
                    value: 'hybrid',
                    child: Text('Hybrid'),
                  ),
                  DropdownMenuItem(
                    value: 'terrain',
                    child: Text('Terrain'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    mapType(value.toString());
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: _currentMapType,
              markers: Set<Marker>.of(_markers),
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              // mapToolbarEnabled: true,
              // compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
                _controller.complete(controller);
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 200,
              width: 300,
              offset: 35,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          navigateToCurrentLocation();
        },
        child: const Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

