import 'package:flutter/material.dart';
import 'package:h3_14_bookie/presentation/widgets/shared/border_layout.dart';

class CategoriesDrawer extends StatelessWidget {
  const CategoriesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
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

    return BorderLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categorias', style: textStyle.titleLarge,),
          _CustomWrap(categories: categories),
          const SizedBox(height: 20,),
          Text('Etiquetas', style: textStyle.titleLarge),
          _CustomWrap(categories: categories),
        ],
      )
    );
  }
}

class _CustomWrap extends StatelessWidget {
  const _CustomWrap({
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Espaciado horizontal entre elementos
      runSpacing: 8.0, // Espaciado vertical entre líneas
      children: categories.map((category) {
        return Chip(
          label: Text(category),
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(color: Colors.grey.shade400),
          ),
        );
      }).toList(),
    );
  }
}
