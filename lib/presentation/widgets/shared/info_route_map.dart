import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/presentation/location/location_provider.dart';
import 'package:h3_14_bookie/presentation/resources/app_images.dart';

class InfoRouteMap extends StatefulWidget {
  final List<LatLng>? positions;
  final bool centerOnUser;
  
  const InfoRouteMap({
    super.key,
    this.positions,
    this.centerOnUser = false,
  });

  @override
  State<InfoRouteMap> createState() => _InfoRouteMapState();
}

class _InfoRouteMapState extends State<InfoRouteMap> {
  // Controllers y Services
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final LocationProvider _locationService = LocationProvider();
  final PolylinePoints _polylinePoints = PolylinePoints();

  // Map Elements
  Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  
  // Marker Icons
  late BitmapDescriptor _iconOn;
  late BitmapDescriptor _iconOff;
  late BitmapDescriptor _iconPosition;
  
  // Location
  LatLng? _currentPosition;

  // Constantes
  static const double _mapZoom = 15;
  static const double _mapBearing = 30;
  static const double _mapPadding = 50;

  // Añade variables para los controladores
  Timer? _locationTimer;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _locationTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeMap() async {
    if (_isDisposed) return;
    
    await _initializeIcons();
    await _fetchLocationUpdate();
    
    if (_isDisposed) return;
    
    if (widget.positions != null) {
      _setMarkers();
      await _getDirectionsRoute();
      
      if (_isDisposed) return;
      
      if (widget.centerOnUser) {
        _centerOnUserLocation();
      } else {
        _centerOnRoutePoints();
      }
    }
  }

  Future<void> _initializeIcons() async {
    _iconPosition = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(45, 45)), 
      AppImages.iconStreetView
    );
    
    if (widget.positions != null) {
      _iconOn = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(30, 40)), 
        AppImages.iconMarkerOn
      );
      _iconOff = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(30, 40)), 
        AppImages.iconMarkerOff
      );
    }
  }

  void _setMarkers() {
    if (!mounted) return;
    
    bool isAlternating = true;
    _markers = widget.positions!.map((position) {
      final marker = Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: isAlternating ? _iconOn : _iconOff,
      );
      isAlternating = !isAlternating;
      return marker;
    }).toSet();
    
    if (mounted) setState(() {});
  }

  Future<void> _getDirectionsRoute() async {
    if (widget.positions == null || widget.positions!.length < 2) return;

    for (int i = 0; i < widget.positions!.length - 1; i++) {
      final origin = PointLatLng(
        widget.positions![i].latitude,
        widget.positions![i].longitude
      );
      
      final destination = PointLatLng(
        widget.positions![i + 1].latitude,
        widget.positions![i + 1].longitude
      );

      try {
        final result = await _polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: 'AIzaSyBKNtPxVrxYRkIVGiPa-sW4aN5sml5UnDE',
          request: PolylineRequest(
            origin: origin,
            destination: destination,
            mode: TravelMode.walking,
            optimizeWaypoints: true,
            alternatives: true,
            avoidHighways: true,
          ),
        );

        if (result.points.isNotEmpty) {
          final polylineCoordinates = result.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          setState(() {
            _polylines.add(Polyline(
              polylineId: PolylineId('route$i'),
              color: Colors.blue,
              points: polylineCoordinates,
              width: 3,
            ));
          });
        }
      } catch (e) {
        debugPrint('Error obteniendo la ruta: $e');
      }
    }
  }

  Future<void> _centerOnUserLocation() async {
    if (_currentPosition == null) return;
    
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition!,
          zoom: _mapZoom,
          bearing: _mapBearing,
        ),
      ),
    );
  }

  Future<void> _centerOnRoutePoints() async {
    if (widget.positions == null || widget.positions!.isEmpty) return;

    final bounds = _calculateBounds();
    final controller = await _controller.future;
    
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, _mapPadding),
    );
  }

  LatLngBounds _calculateBounds() {
    double minLat = widget.positions!.first.latitude;
    double maxLat = widget.positions!.first.latitude;
    double minLng = widget.positions!.first.longitude;
    double maxLng = widget.positions!.first.longitude;

    for (final position in widget.positions!) {
      minLat = min(minLat, position.latitude);
      maxLat = max(maxLat, position.latitude);
      minLng = min(minLng, position.longitude);
      maxLng = max(maxLng, position.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  Future<void> _fetchLocationUpdate() async {
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null && mounted) {
        setState(() => _currentPosition = position);
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: 'Error obteniendo la ubicación: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      markers: {
        ..._markers,
        Marker(
          markerId: const MarkerId('sourceLocation'),
          icon: _iconPosition,
          position: _currentPosition!,
        ),
      },
      polylines: _polylines,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _currentPosition!,
        zoom: _mapZoom,
        bearing: _mapBearing,
      ),
      onMapCreated: (controller) {
        _controller.complete(controller);
        _setMapStyle(controller);
      },
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      compassEnabled: false,
    );
  }

  Future<void> _setMapStyle(GoogleMapController controller) async {
    const String style = '''
      [
        {
          "featureType": "poi",
          "elementType": "labels",
          "stylers": [{"visibility": "off"}]
        },
        {
          "featureType": "transit",
          "elementType": "labels",
          "stylers": [{"visibility": "off"}]
        }
      ]
    ''';
    // ignore: deprecated_member_use
    await controller.setMapStyle(style);
  }
}