import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/presentation/location/location_provider.dart';
import 'package:h3_14_bookie/presentation/resources/app_images.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class CustomMapInfoWidget extends StatefulWidget {
  const CustomMapInfoWidget({
    super.key,
    this.positions,
  });

  final List<LatLng>? positions;

  @override
  State<CustomMapInfoWidget> createState() => _CustomMapInfoWidgetState();
}

class _CustomMapInfoWidgetState extends State<CustomMapInfoWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late BitmapDescriptor iconOn;
  late BitmapDescriptor iconOff;
  late BitmapDescriptor iconPostion;
  Set<Marker> markers = {};
  final LocationProvider _locationService = LocationProvider();
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    initData();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await fetchLocationUpdate());
  }

  Future<void> initData() async {
    setIconPosition();
    if (widget.positions != null) {
      await setIcon();
      setMarkers();
    }
  }

  Future<void> setIcon() async {
    iconOn = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(35, 40)), AppImages.iconMarkerOn);
    iconOff = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(35, 40)), AppImages.iconMarkerOn);
  }

  Future<void> setIconPosition() async {
    iconPostion = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(45, 45)), AppImages.iconStreetView);
  }

  void setMarkers() {
    bool flag = true;
    for (var position in widget.positions!) {
      markers.add(
        Marker(
          onTap: () async {
            showCustomCardModal(context);
          },
          markerId: MarkerId(position.toString()),
          position: position,
          icon: flag ? iconOn : iconOff,
          // infoWindow: InfoWindow(
          //   title: 'La montaña',
          //   onTap: () async {
          //     _dialogBuilder(context);
          //   }
          // ),
        ),
      );
      flag = !flag;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return currentPosition == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            markers: {
              ...markers,
              Marker(
                markerId: const MarkerId('sourceLocation'),
                icon: iconPostion,
                position: currentPosition!,
              ),
            },
            mapType: MapType.normal,
            style:
                ''' [ { "featureType": "poi", "elementType": "labels", "stylers": [ { "visibility": "off" } ] }, { "featureType": "transit", "elementType": "labels", "stylers": [ { "visibility": "off" } ] } ] ''',
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 17,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
  }

  Future<void> fetchLocationUpdate() async {
    final position = await _locationService.getCurrentLocation();
    if (position != null && mounted) {
      setState(() {
        currentPosition = position;
      });
    }
  }

  void showCustomCardModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BookCardWidget(
              imageUrl: 'https://example.com/image.png',
              title: 'Título',
              synopsis: 'Sinopsis... En un pueblo olvidado...',
              categories: ['Terror', 'Suspenso'],
              rating: 4.2,
              reads: 10000,
            ),
          ),
        );
      },
    );
  }
  
}
