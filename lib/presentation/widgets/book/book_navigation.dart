import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class BookNavigation extends StatelessWidget {
  const BookNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.accentColor,
            ),
            color: AppColors.primaryColor,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.primaryColor,
                value: 60,
              ),
            ),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.accentColor,
            ),
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}