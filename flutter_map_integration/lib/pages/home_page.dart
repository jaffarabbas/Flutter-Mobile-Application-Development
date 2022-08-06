import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.860966, 66.990501),
    zoom: 14.4746,
  );

  List<Marker> _markers = [];
  List<Marker> list  = const [
    Marker(markerId: MarkerId('marker1'),
        position: LatLng(24.860966, 66.990501),
        infoWindow: InfoWindow(title: 'Marker 1')
    ),
    Marker(markerId: MarkerId('marker2'),
        position: LatLng(24.871940, 66.988060),
        infoWindow: InfoWindow(title: 'Marker 2')
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Integration'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.satellite,
        markers: Set<Marker>.of(_markers),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        // mapToolbarEnabled: true,
        // compassEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}