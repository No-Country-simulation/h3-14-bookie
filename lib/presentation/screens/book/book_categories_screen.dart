import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/entities/category_user_entity.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookCategoriesScreen extends StatelessWidget {
  static const String name = 'book-categories';
  const BookCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Terror',
      'Acción',
      'Aventura',
      'Ciencia Ficción',
      'Fanfic'
    ];
    // List<CategoryUserEntity> list =
    return Scaffold(
      appBar: const CustomTitleAppbar(title: 'Categorías'),
      body: BorderLayout(
        child: BlocBuilder<BookCreateBloc, BookCreateState>(
          builder: (context, state) {
            return Column(
              children: state.categories.map((c) {
                return _CustomChipSelect(
                  label: c.name,
                  active: c.isActive,
                  onTap: (){
                    context.read<BookCreateBloc>().add(ToogleCategoryEvent(uidCategory: c.uid));
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class _CustomChipSelect extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _CustomChipSelect({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(30.0),
            color: active ? AppColors.secondaryColor : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style:
                  const TextStyle(fontSize: 16.0, color: AppColors.primaryColor),
              textAlign: TextAlign.center,
            ),
            if (active) ...[
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.check,
                color: AppColors.primaryColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}
