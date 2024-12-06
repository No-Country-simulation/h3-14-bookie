import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

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
        context.go('/home/3/book-create');
      },
    );
  }
}