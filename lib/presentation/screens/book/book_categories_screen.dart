import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookCategoriesScreen extends StatelessWidget {
  static const String name = 'book-categories';
  const BookCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<CategoryUserEntity> list =
    return Scaffold(
      appBar: const CustomTitleAppbar(title: 'Categorías'),
      body: BorderLayout(
        child: BlocBuilder<BookCreateBloc, BookCreateState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: state.categories.map((c) {
                  return CustomChipSelect(
                    label: c.name,
                    active: c.isActive,
                    onTap: (){
                      context.read<BookCreateBloc>().add(ToogleCategoryEvent(uidCategory: c.uid));
                    },
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
