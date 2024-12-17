import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/presentation/blocs/book/favorite_view/favorite_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'Mi biblioteca',
            style: textStyle.titleLarge!.copyWith(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(),
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
              return state.listFavorites.isEmpty
              ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: Text('Aún no tienes historias en tu biblioteca.'),))
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: state.loadingFavorites
                    ? const Center(child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),) 
                    : GridView.builder(
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
                    final story = state.listFavorites[index].reading;
                    return GestureDetector(
                      onTap: () {
                        context.push('/home/0/book/${story.storyId}');
                      },
                      child: BookWidget(
                        isFavorite: true,
                        story: StoryResponseDto(
                            story.storyId, story.title??'(Título)', '', story.cover??'', story.synopsis??'', [], [], 0, 0, 0, [], true),
                        onFavorite: () {
                          context.read<FavoriteViewBloc>().add(ChangeFavoriteStoryFavorites(index: index));
                        },
                      ),
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
