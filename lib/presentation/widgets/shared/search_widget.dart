import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.secondaryColor,
        border: Border.all(color: AppColors.background)
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.background),
          SizedBox(width: 10,),
          Text('Busca historias')
        ],
      ),
    );
  }
}