import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/get_it/locator.dart';
import 'package:h3_14_bookie/presentation/blocs/home_view/home_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        const CustomAppbar(),
        Expanded(
          child: Column(
            children: [
              BorderLayout(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Historias cerca',
                      style: textStyle.titleLarge!
                          .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          EndDrawerWidget.instance.body =
                              const FilterStoryHomeDrawer();
                          locator<GlobalKey<ScaffoldState>>()
                              .currentState!
                              .openEndDrawer();
                        },
                        icon: const Icon(Icons.sort, size: 30))
                  ],
                ),
              ),
              BlocBuilder<HomeViewBloc, HomeViewState>(
                  builder: (context, state) {
                    return Expanded(
                      child: state.isLoading 
                      ? const Center(child: CircularProgressIndicator(),)
                      : state.stories.isEmpty
                      ? const Center(
                        child: Text(
                          'No tienes historias en tu biblioteca, \n mueve para descubrir más.',
                          textAlign: TextAlign.center,),)
                      : GridView.builder(
                        // clipBehavior: Clip.none,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          mainAxisExtent: 290,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: state.stories.length,
                        itemBuilder: (context, index) {
                          bool isSecondColumn = index % 2 == 1;
                          return Transform.translate(
                            offset: Offset(0, isSecondColumn ? 20.0 : 0.0),
                            child: GestureDetector(
                                onTap: () {
                                  context.push('/home/0/book/${state.stories[index].story.storyUid}');
                                },
                                child: BookWidget(
                                  onFavorite: () {
                                    context.read<HomeViewBloc>().add(ChangeFavoriteStoryHome(index: index));
                                  },
                                  story: state.stories[index].story,
                                  isFavorite: state.stories[index].isFavorite,
                                )),
                          );
                        },
                      ),
                    );
                  },
                )
            ],
          ),
        )
      ],
    );
  }
}
