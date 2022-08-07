import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineIntegration extends StatefulWidget {
  const PolyLineIntegration({Key? key}) : super(key: key);

  @override
  State<PolyLineIntegration> createState() => _PolyLineIntegrationState();
}

class _PolyLineIntegrationState extends State<PolyLineIntegration> {
  Completer<GoogleMapController> _controller = Completer();

  MapType _currentMapType = MapType.normal;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8959986, 67.0300502),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline= {};

  // List<Marker> _markers = [];

  List<LatLng> _latLng = [
    LatLng(24.8959986, 67.0300502),
    LatLng(24.860966, 66.990501),
    // LatLng(24.871940, 66.988060),
    // LatLng(24.8959986,67.0300502),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoad();
  }

  onLoad() {
    for (var i = 0; i < _latLng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLng[i],
          infoWindow: InfoWindow(
            title: 'Marker ${i}',
            snippet: 'This is marker ${i}',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        ),
      );
      setState(() {});
      _polyline.add(
        Polyline(
          polylineId: PolylineId(i.toString()),
          points: _latLng,
          color: Colors.blue,
          width: 10,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polyline Integration'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: _currentMapType,
        polylines: _polyline,
        markers: _markers,
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
