import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/domain/model/story.dart';

import 'package:h3_14_bookie/presentation/widgets/getStructure/get%20structure.dart';
import 'package:h3_14_bookie/presentation/widgets/home/book_widget.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    const CameraPosition cameraPosition = CameraPosition(
      bearing: 0,
      target: LatLng(-34.625946, -58.463903),
      tilt: 60, // Reducido de 80 a 60 para una mejor perspectiva
      zoom: 5, // Un buen valor para ver calles y edificios claramente
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 10), // Espaciado entre AppBar y encabezado
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 28),
          //   child: Text(
          //     'Continuar leyendo',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 24,
          //       fontFamily: 'Roboto',
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 16),
          // SizedBox(
          //   height: 290,
          //   child: ListView.builder(
          //     clipBehavior: Clip.none,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 10,
          //     itemBuilder: (context, index) {
          //       return const Padding(
          //         padding: EdgeInsets.only(left: 16),
          //         child: BookReadWidget(),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 28),
          //   child: Text(
          //     'Tu colección',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 24,
          //       fontFamily: 'Roboto',
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 16),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: GridView.builder(
          //     physics: const NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     itemCount: 10,
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 16,
          //       mainAxisSpacing: 16,
          //       childAspectRatio: 180 / 290,
          //     ),
          //     itemBuilder: (context, index) {
          //       // return BookWidget(story: Story(categories: []),);
          //     },
          //   ),
          // ),
          Text(
            'text prueba 11',
            style: TextStyle(fontSize: 11),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 12',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 13',
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 14',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 15',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 16',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 17',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 18',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 19',
            style: TextStyle(fontSize: 19),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 20',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'text prueba 21',
            style: TextStyle(fontSize: 21),
          ),
          // SizedBox(
          //     width: double.infinity,
          //     height: 250,
          //     child: InfoRouteMap(
          //       centerOnUser: false,
          //       positions: const [
          //         LatLng(37.40523168383278, -122.15067051351069),
          //         LatLng(37.40209318936961, -122.14084122329949)
          //       ],
          //     )
          //     )
        ],
      ),
    );
  }
}
