import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomeMarker extends StatefulWidget {
  const CustomeMarker({Key? key}) : super(key: key);

  @override
  State<CustomeMarker> createState() => _CustomeMarkerState();
}

class _CustomeMarkerState extends State<CustomeMarker> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8959986,67.0300502),
    zoom: 14.4746,
  );

  List<Marker> _markers = [];
  List<String> images = ["assets/images/car.png", "assets/images/food-delivery.png", "assets/images/walk.png"];

  List<LatLng> _latLng = [
    LatLng(24.860966, 66.990501),
    LatLng(24.871940, 66.988060),
    LatLng(24.8959986,67.0300502),
  ];

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

  Future<Uint8List> getBytesFromAssets(String path,int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List(); 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  void loadData() async{
    for(int i = 0; i < images.length; i++){
      print(images[i]);
       final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLng[i],
          infoWindow: InfoWindow(title: "Marker $i"),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );
      setState(() {
        
      });
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
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: _currentMapType,
          markers: Set<Marker>.of(_markers), 
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          // mapToolbarEnabled: true,
          // compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
