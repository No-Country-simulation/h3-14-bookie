import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';

class FloatingButtonAddBook extends StatelessWidget {
  const FloatingButtonAddBook({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      backgroundColor: AppColors.primaryColor,
      child: const Icon(Icons.add_rounded, size: 25, color: AppColors.background,),
      onPressed: (){
        context.read<BookCreateBloc>().add(const InitCategoriesEvent());
        context.go('/home/3/book-create');
      },
    );
  }
}