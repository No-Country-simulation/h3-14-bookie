import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class BookInfoScreen extends StatefulWidget {
  static const name = 'book-screen';
  final String bookId;
  const BookInfoScreen({super.key, required this.bookId});

  @override
  State<BookInfoScreen> createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kLake = CameraPosition(
      bearing: 0,
      target: LatLng(-34.625946, -58.463903),
      tilt: 0,
      zoom: 14);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    const locations = [
      'Plaza de la prevalencia',
      'Café Torres',
      'Parque Versalles'
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.book_outlined))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.primaryColor,
            height: 1.0,
          )
        ),
        shadowColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: BorderLayout(
          child: Column(
            children: [
              Container(
                width: size.width * 0.6,
                height: size.width * 0.6,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(15)
                ),
              ),
              const SizedBox(height: 10,),
              Text('Las aves no lloran', style: textStyle.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(backgroundColor: AppColors.secondaryColor,),
                      SizedBox(width: 10,),
                      Text('Autor'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule_outlined),
                      Text('30 min')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sinopsis',
                      style: textStyle.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left,),
                    const Text(
                      'Este libro es una pequeña historia de un pájaro que no puede volar, pero que gracias a su astucia, consigue ser piloto de un dron con el que gana algunos premios.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                )
              ),
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StarRating(calification: 4),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined),
                      SizedBox(width: 5,),
                      Text('10K reads')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                width: size.width * 0.9,
                height: size.width * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CustomMapWidget(postion: _kLake, controller: _controller),
                ),
              ),
              const SizedBox(height: 10,),
              const IconLabelWidget(label: 'Próxima ubicación a 2km', icon: Icons.place_outlined, center: true,),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Lugares'),
                    const SizedBox(height: 10,),
                    ...locations.map((location) => IconLabelWidget(label: location, icon: Icons.push_pin_outlined)),
                    const SizedBox(height: 15,),
                    const Text('Capítulos'),
                    const SizedBox(height: 10,),
                    ...locations.asMap().entries.map((entry) {
                      int index = entry.key;
                      var location = entry.value;
                      return IconLabelWidget(
                        label: 'Capítulo ${index + 1}: $location',
                        icon: Icons.list,
                      );
                    })
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () => context.push('/home/0/book/1/read'),
                  child: const Text('Leer'),
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
