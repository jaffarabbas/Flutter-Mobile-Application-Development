import 'dart:async';

import 'package:flutter/material.dart';
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
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.860966, 66.990501),
    zoom: 14.4746,
  );

  List<Marker> _markers = [];
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
      _markers.add(
        Marker(
          markerId: MarkerId("2"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
              title: 'My location',
              snippet: "Lat: ${value.latitude} Long: ${value.longitude}"),
        ),
      );

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(list);
    navigateToCurrentLocation();
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
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: _currentMapType,
          markers: Set<Marker>.of(_markers),
          // myLocationButtonEnabled: true,
          // myLocationEnabled: true,
          // mapToolbarEnabled: true,
          // compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
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
