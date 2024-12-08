import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/presentation/resources/app_images.dart';

class CustomMapInfoWidget extends StatefulWidget {
  const CustomMapInfoWidget({
    super.key,
    required CameraPosition postion,
    // required Completer<GoogleMapController> controller,
    this.positions
  }) : _position = postion;

  final CameraPosition _position;
  // final Completer<GoogleMapController> _controller;
  final List<LatLng>? positions;

  @override
  State<CustomMapInfoWidget> createState() => _CustomMapInfoWidgetState();
}

class _CustomMapInfoWidgetState extends State<CustomMapInfoWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late BitmapDescriptor iconOn;
  late BitmapDescriptor iconOff;
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    if(widget.positions != null) {
      await setIcon();
      setMarkers();
    }
  }

  Future<void> setIcon() async {
    iconOn = await BitmapDescriptor.asset(const ImageConfiguration(size: Size(45, 45)), AppImages.iconMarkerOn);
    iconOff = await BitmapDescriptor.asset(const ImageConfiguration(size: Size(45, 45)), AppImages.iconMarkerOn);
  }

  void setMarkers() {
    bool flag = true;
    for (var position in widget.positions!) {
      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          icon: flag? iconOn : iconOff,
          infoWindow: const InfoWindow(
            title: 'Distancia a 30km'
          )
        )
      );
      flag = !flag;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      style: ''' [ { "featureType": "poi", "elementType": "labels", "stylers": [ { "visibility": "off" } ] }, { "featureType": "transit", "elementType": "labels", "stylers": [ { "visibility": "off" } ] } ] ''',
      initialCameraPosition: widget._position,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
