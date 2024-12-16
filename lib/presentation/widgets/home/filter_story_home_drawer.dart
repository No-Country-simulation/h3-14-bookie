import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/home_view/home_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/shared/border_layout.dart';

class FilterStoryHomeDrawer extends StatelessWidget {
  const FilterStoryHomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontWeight: FontWeight.bold);
    final List<String> categories = [
      "Acción",
      "Aventura",
      "Ciencia Ficción",
      "Cuento",
      "Fanfic",
      "Fantasía",
      "Novela",
      "Poesía",
      "Romance",
      "Suspenso",
      "Terror",
    ];

    final List<String> etiquetas = [
      "lobos",
      "anime",
      "vampiros",
      "enemiestolovers",
      "juvenil",
      "mafia",
      "adultos",
    ];

    return BorderLayout(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Categorías',
          style: textStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<HomeViewBloc, HomeViewState>(
          builder: (context, state) {
            return _CustomWrap(
              categories: state.categories.map((c)=>c.name).toList(),
              isTag: false,
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Text('Etiquetas', style: textStyle),
        const SizedBox(
          height: 10,
        ),
        _CustomWrap(
          categories: etiquetas,
          isTag: true,
        ),
      ],
    ));
  }
}

class _CustomWrap extends StatelessWidget {
  final List<String> categories;
  final bool isTag;

  const _CustomWrap({
    required this.categories,
    required this.isTag,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Espaciado horizontal entre elementos
      runSpacing: 8.0, // Espaciado vertical entre líneas
      children: categories.map((category) {
        return Chip(
          label: Text(
            (isTag ? '#' : '') + category,
            style: const TextStyle(color: AppColors.primaryColor),
          ),
          backgroundColor: AppColors.background,
          shape: const StadiumBorder(
            side: BorderSide(color: AppColors.primaryColor),
          ),
        );
      }).toList(),
    );
  }
}
