import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyGoneIntegration extends StatefulWidget {
  const PolyGoneIntegration({Key? key}) : super(key: key);

  @override
  State<PolyGoneIntegration> createState() => _PolyGoneIntegrationState();
}

class _PolyGoneIntegrationState extends State<PolyGoneIntegration> {
  Completer<GoogleMapController> _controller = Completer();
 
  MapType _currentMapType = MapType.normal;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8959986,67.0300502),
    zoom: 14.4746,
  );

  // final Set<Marker> _markers = {};
  Set<Polygon> _polygon = HashSet<Polygon>();

  // List<Marker> _markers = [];

  List<LatLng> _latLng = [
    LatLng(24.8959986,67.0300502),
    LatLng(24.860966, 66.990501),
    LatLng(24.871940, 66.988060),
    LatLng(24.8959986,67.0300502),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(
        polygonId: PolygonId('polygon'),
        points: _latLng,
        fillColor: Colors.blue.withOpacity(0.2),
        geodesic: true,
        strokeColor: Colors.blue,
        strokeWidth: 1,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygone Integration'),
      ),
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: _currentMapType,
          polygons: _polygon,
          // markers: Set<Marker>.of(_markers), 
          // myLocationButtonEnabled: true,
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