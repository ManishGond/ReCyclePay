import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> _markers = <Marker>[];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.954760, 77.574360),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _markers.add(const Marker(
        markerId: MarkerId('1'),
        position: LatLng(12.954214416811315, 77.57716605448773),
        infoWindow: InfoWindow(title: 'Test Bengaluru')));
    _markers.add(const Marker(
        markerId: MarkerId('2'),
        position: LatLng(12.953219643213103, 77.57454536963685),
        infoWindow: InfoWindow(title: 'Test Bengaluru')));
    _markers.add(const Marker(
        markerId: MarkerId('3'),
        position: LatLng(12.955023977301042, 77.5755403880569),
        infoWindow: InfoWindow(title: 'Test Bengaluru')));
    _markers.add(const Marker(
        markerId: MarkerId('4'),
        position: LatLng(12.955204440134748, 77.5740364620285),
        infoWindow: InfoWindow(title: 'Test Bengaluru')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          trafficEnabled: false,
          rotateGesturesEnabled: true,
          buildingsEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
