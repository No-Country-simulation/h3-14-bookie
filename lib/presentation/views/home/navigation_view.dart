import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {

    const CameraPosition kLake = CameraPosition( bearing: 0, target: LatLng(-34.625946, -58.463903), tilt: 80, zoom: 18, );
    // CameraPosition(
    //     bearing: 0, target: LatLng(-34.625946, -58.463903), tilt: 0, zoom: 18);
        
    return Container(
      child: CustomMapInfoWidget(
        postion: kLake,
        positions: const [
          LatLng(-34.718215, -58.260557),
          LatLng(-34.625955, -58.462272),
          LatLng(-34.624675, -58.466049),
          LatLng(-34.625222, -58.467905),
        ],
      )
    );
  }
}
