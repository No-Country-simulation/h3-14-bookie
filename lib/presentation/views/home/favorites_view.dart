import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';
import 'package:h3_14_bookie/presentation/blocs/book/bloc/favorite_view_bloc.dart';

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
          const SizedBox(height: 10), // Espaciado entre AppBar y encabezado
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              'Continuar leyendo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 290,
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: BookReadWidget(),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              'Tu colección',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<FavoriteViewBloc, FavoriteViewState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.listFavorites.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 180 / 290,
                  ),
                  itemBuilder: (context, index) {
                    return BookWidget(
                      isFavorite: true,
                      story: StoryResponseDto(
                          '', '', '', '', '', [], [], 0, 0, 0, []),
                      onFavorite: () {
                        context.read<FavoriteViewBloc>().add(ChangeFavoriteStoryFavorites(index: index));
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
