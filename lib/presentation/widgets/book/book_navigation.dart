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
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor,)
            )
          ),
          const SizedBox(width: 20,),
          const Expanded(
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFFDADADA),
              value: 0.6,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              minHeight: 5,
            )
          ),
          const SizedBox(width: 20,),
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.accentColor,
            ),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor,)
            ),
          )
        ],
      ),
    );
  }
}