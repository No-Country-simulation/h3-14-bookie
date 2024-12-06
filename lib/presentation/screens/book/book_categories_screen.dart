import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookCategoriesScreen extends StatelessWidget {
  static const String name = 'book-categories';
  const BookCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregando Categoría'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primaryColor,
              height: 1.0,
            )),
        shadowColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: BorderLayout(
        child: Column(
          
        ),
      ),
    );
  }
}